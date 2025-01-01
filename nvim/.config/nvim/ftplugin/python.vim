let python_path = system("which python")
if !empty(python_path)
    let g:python3_host_prog = python_path
endif
