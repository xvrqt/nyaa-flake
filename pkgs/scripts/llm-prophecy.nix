{pkgs, ...}: let
  jq = "${pkgs.jq}/bin/jq";
  curl = "${pkgs.curl}/bin/curl";
  ollama = "${pkgs.ollama}/bin/ollama";
  figlet = "${pkgs.figlet}/bin/figlet";
  lolcat = "${pkgs.lolcat}/bin/lolcat";
  ripgrep = "${pkgs.ripgrep}/bin/rg";

  model = "llama2-uncensored:70b";
  prompt = "Provide an ominous, unsettling, prophecy about how my day will go. For context, I am an American, 32 year old trans woman that lives in Seattle. My name is Amy and I own two cats. I spend most of my time doing 3D modeling on Blender, making videos, and ricing my NixOS operating system. I am in a lesbian relationship. Do not mention any of these facts directly, only use them to guide your prophecy.";
in
  # Tests current flake configuration, outputs diffs of changes
  pkgs.writeShellScriptBin "llm-prophecy" ''
    # Start the server (this is run on startup so it is not likley running)
    # If it is running then it just writes an error and proceeds
    ${ollama} serve 2> /dev/null &

    # Check to see if the model is already installed
    model=$(${ollama} list | ${ripgrep} ${model})

    # Check if the model is already downloaded, and pulls if it absent
    if [ -n "$model" ]; then
      ${ollama} pull ${model} 2> /dev/null
    fi

    # Talk to the LLM server via http with our prompt. Parse, format, and display
    ${curl} -s http://localhost:11434/api/generate -d '{"model": "${model}", "prompt": "${prompt}", "stream": false }' | ${jq} '.response' | ${figlet} -f cybermedium -t -c -p | ${lolcat}

    # Kill the server if we started it, since it will be started with the DE
    kill %1
  ''
