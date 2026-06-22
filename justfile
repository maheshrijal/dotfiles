bench-shell:
    #!/usr/bin/env python3
    import os
    import shutil
    import statistics
    import subprocess
    import tempfile
    import time
    from pathlib import Path

    runs = 30
    warmups = 3
    root = Path.cwd()
    src = root / "home" / "private_dot_config" / "private_fish"

    def percentile_95(samples):
        return statistics.quantiles(samples, n=20)[18]

    def benchmark(name, command, env=None):
        for _ in range(warmups):
            subprocess.run(command, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, env=env, check=False)

        samples = []
        for _ in range(runs):
            start = time.perf_counter()
            subprocess.run(command, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, env=env, check=False)
            samples.append((time.perf_counter() - start) * 1000)

        print(name)
        print(f"  mean   {statistics.mean(samples):7.2f} ms")
        print(f"  median {statistics.median(samples):7.2f} ms")
        print(f"  p95    {percentile_95(samples):7.2f} ms")
        print(f"  min    {min(samples):7.2f} ms")
        print(f"  max    {max(samples):7.2f} ms")

    with tempfile.TemporaryDirectory(prefix="dotfiles-fish.") as tmp:
        fish_dir = Path(tmp) / "fish"
        shutil.copytree(src, fish_dir)

        env = os.environ.copy()
        env["XDG_CONFIG_HOME"] = tmp

        benchmark("repo_config_interactive_exit", ["fish", "-i", "-c", "exit"], env)
        benchmark("repo_config_noninteractive_true", ["fish", "-c", "true"], env)
        benchmark("fish_no_config_interactive", ["fish", "--no-config", "-i", "-c", "exit"])
        benchmark("fish_no_config_noninteractive", ["fish", "--no-config", "-c", "true"])
