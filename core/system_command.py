import os
import subprocess

from talon import Module, actions

mod = Module()


@mod.action_class
class Actions:
    def system_command(cmd: str):
        """execute a command on the system"""
        os.system(cmd)

    def system_command_nb(cmd: str):
        """execute a command on the system without blocking"""
        subprocess.Popen(cmd, shell=True)

    def system_command_nb_get_text(cmd: str):
        """non blocking get text"""
        subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
        # Read the output from the pipe
        output = process.communicate()[0]
        # Decode the output from bytes to a string
        output = output.decode()
        return output

    def ps_command_nb(f: str):
        """execute a fn for ps repl via bb nrepl command"""
        code_path = '"/Users/ryan/dev/ps script/plugins/ps-scittle-repl"'
        ps_require_str = "(require 'playground)"
        # cljs_call =  '"' + ps_require_str + " " + f + '"'
        cljs_call =  '"' + f + '"'
        cmd = 'cd ' +  code_path + ' ; bb nrepl-eval ' + cljs_call
        print(cmd)
        subprocess.Popen(cmd, shell=True)

    def bb_run_fn(input_text: str, bb_fn_name: str, bb_path: str) -> str:
        """run a bb fn with input text"""
        talon_user_path = "/Users/ryan/.talon/user/"
        talon_bb_folder_path = talon_user_path + bb_path
        change_folder_cmd = "cd " + talon_bb_folder_path
        bb_cmd =  "bb -x " + bb_fn_name 
        cmd = change_folder_cmd + " && " + bb_cmd 
        print(f"Command: {cmd}")
        process = subprocess.Popen(
            cmd,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            shell=True)
        stdout, stderr = process.communicate(input=input_text)
        # print(f"Stdout: {stdout.strip()}")
        # print(f"Stderr: {stderr.strip()}")
        if process.returncode != 0:
            print(f"Error: {stderr.strip()}")
            return None
        bb_result = stdout.strip() 
        if bb_result is None:
            print("bb result is actually None")
        elif bb_result == '':
            print("bb result is an empty string")
        # else:
        #     print("bb result is: ", bb_result.upper())
        return bb_result
    
    def print_type(x: object):
        """debugging print type"""
        print(f"Type: {type(x)}")

    def bb_transform_text(input_text: str, bb_fn_name: str) -> str:
         """tranforms a string with bb"""
        #  print(f"Input to bb_transform_text: {input_text}")
         x = actions.user.bb_run_fn(input_text, bb_fn_name, "ryan/clojure/string-fns/")
        #  print(f"Transformed text: {x}")
        #  print(f"Type of transformed text: {type(x)}")
        #  if x is None:
        #     print("Warning: bb_transform_text is returning None.")
         return x