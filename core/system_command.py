import os
import subprocess

from talon import Module

mod = Module()


@mod.action_class
class Actions:
    def system_command(cmd: str):
        """execute a command on the system"""
        os.system(cmd)

    def system_command_nb(cmd: str):
        """execute a command on the system without blocking"""
        subprocess.Popen(cmd, shell=True)

    def ps_command_nb(f: str):
        """execute a fn for ps repl via bb nrepl command"""
        cmd = 'cd "/Users/ryan/dev/ps script/plugins/scittle-repl"; bb nrepl-eval "' + f + '"' 
        subprocess.Popen(cmd, shell=True)
