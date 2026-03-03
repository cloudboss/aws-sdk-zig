const std = @import("std");

pub const AppType = enum {
    jupyter_server,
    kernel_gateway,
    detailed_profiler,
    tensor_board,
    code_editor,
    jupyter_lab,
    r_studio_server_pro,
    r_session_gateway,
    canvas,

    pub const json_field_names = .{
        .jupyter_server = "JupyterServer",
        .kernel_gateway = "KernelGateway",
        .detailed_profiler = "DetailedProfiler",
        .tensor_board = "TensorBoard",
        .code_editor = "CodeEditor",
        .jupyter_lab = "JupyterLab",
        .r_studio_server_pro = "RStudioServerPro",
        .r_session_gateway = "RSessionGateway",
        .canvas = "Canvas",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .jupyter_server => "JupyterServer",
            .kernel_gateway => "KernelGateway",
            .detailed_profiler => "DetailedProfiler",
            .tensor_board => "TensorBoard",
            .code_editor => "CodeEditor",
            .jupyter_lab => "JupyterLab",
            .r_studio_server_pro => "RStudioServerPro",
            .r_session_gateway => "RSessionGateway",
            .canvas => "Canvas",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
