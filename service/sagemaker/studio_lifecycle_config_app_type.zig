const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .jupyter_server => "JupyterServer",
            .kernel_gateway => "KernelGateway",
            .code_editor => "CodeEditor",
            .jupyter_lab => "JupyterLab",
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
