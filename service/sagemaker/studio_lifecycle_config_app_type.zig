pub const StudioLifecycleConfigAppType = enum {
    jupyter_server,
    kernel_gateway,
    code_editor,
    jupyter_lab,

    pub const json_field_names = .{
        .jupyter_server = "JupyterServer",
        .kernel_gateway = "KernelGateway",
        .code_editor = "CodeEditor",
        .jupyter_lab = "JupyterLab",
    };
};
