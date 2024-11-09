" If there is an active conda environment, use its Python interpreter
if !empty($CONDA_PREFIX)
    let g:python3_host_prog = $CONDA_PREFIX . '/bin/python3'
else
    let g:python3_host_prog = '/usr/bin/python3'
endif
