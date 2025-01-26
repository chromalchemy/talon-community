import os
import subprocess
import shlex

from talon import Module, actions

mod = Module()


@mod.action_class
class Actions:
    def system_command(cmd: str):
        """execute a command on the system"""
        os.system(cmd)

    def system_command_run(cmd: str):
        """execute a command on the system with subprocess.run"""
        print(f"system_command_run: {cmd}")
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        print(result.stdout)

    def system_command_nb(cmd: str):
        """execute a command on the system without blocking"""
        print(f"system_command_nb: {cmd}")
        process = subprocess.Popen(
            cmd, 
            shell=True, 
            stdout=subprocess.PIPE, 
            stderr=subprocess.PIPE)
        stdout, stderr = process.communicate()  # Waits for the process to finish
        print("Command completed:", stdout.decode(), stderr.decode())

    def system_command_nb_cmd_segments(cmd: list[str]):
        """execute a command on the system without blocking"""
        print(f"system_command_nb: {shlex.join(cmd)}")
        process = subprocess.Popen(
            cmd, 
            stdout=subprocess.PIPE, 
            stderr=subprocess.PIPE)
        stdout, stderr = process.communicate()  # Waits for the process to finish
        print("Command completed:", stdout.decode(), stderr.decode())

    def system_command_nb_get_text(cmd: str):
        """non blocking get text"""
        subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
        output = process.communicate()[0] # Read the output from the pipe
        output = output.decode() # Decode the output from bytes to a string
        return output

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