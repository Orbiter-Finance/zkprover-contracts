import { exec } from "child_process";
import { promisify } from "util";

const executeCommand = async (command: string): Promise<string> => {
    const execAsync = promisify(exec);
    try {
      const { stdout, stderr } = await execAsync(command);
      if (stderr) {
        throw new Error(stderr);
      }
      return stdout;
    } catch (error) {
      throw new Error(`Failed to execute command: ${error}`);
    }
  };

export const compile_yul = async (codePath: string):Promise<string> => {
  const cmd = `solc --bin --yul ${codePath}`;
  console.log(`cmdString ${cmd}`);

  const output = await executeCommand(cmd);
  let string_slice = output.split(/[\s\n]/);
  let evm_compiled_code = string_slice[string_slice.length - 2];

  return evm_compiled_code

}

export const encode_zkp_call_data = () => {

}

export const halo2zkpVerifierAbi = [
  // {
  //     "constant": false,
  //     "inputs": [],
  //     "name": "myFunction",
  //     "outputs": [],
  //     "payable": false,
  //     "stateMutability": "nonpayable",
  //     "type": "function"
  //   }
];
