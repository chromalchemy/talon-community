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
        cmd = 'cd "/Users/ryan/dev/ps script/plugins/scittle-repl"; bb nrepl-eval "' + f + '"' 
        subprocess.Popen(cmd, shell=True)

    def bb_run_fn(input_text: str, bb_fn_name: str, bb_path: str) -> str:
        """run a bb fn with input text"""
        talon_user_path = "/Users/ryan/.talon/user/"
        talon_bb_folder_path = talon_user_path + bb_path
        change_folder_cmd = "cd " + talon_bb_folder_path
        bb_cmd =  "bb -x " + bb_fn_name 
        cmd = change_folder_cmd + " && " + bb_cmd 
        process = subprocess.Popen(
            cmd,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            shell=True)
        stdout, stderr = process.communicate(input=input_text)
        if process.returncode != 0:
            print(f"Error: {stderr.strip()}")
            return None
        bb_result = stdout.strip() 
        if bb_result:
            print("bb result is: ", bb_result.upper())
        else:
            print("bb result is None")
        print(type(bb_result))
        return bb_result
    
    def bb_transform_text(input_text: str, bb_fn_name: str):
         """tranforms a string with bb"""
         actions.user.bb_run_fn(input_text, bb_fn_name, "ryan/clojure/string-fns/") 
    

    def betterdisplay_set(f: str):
        """execute a betterdisplay command"""
        cmd = 'betterdisplaycli set --UUID=37D8832A-2D66-02CA-B9F7-8F30A301B230 --' + f + '; exit 0' 
        subprocess.Popen(cmd, shell=True)

    def betterdisplay_toggle(f: str):
        """execute a betterdisplay command"""
        cmd = 'betterdisplaycli toggle --UUID=37D8832A-2D66-02CA-B9F7-8F30A301B230 -' + f + '; exit 0' 
        subprocess.Popen(cmd, shell=True)
