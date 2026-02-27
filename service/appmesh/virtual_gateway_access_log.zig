const VirtualGatewayFileAccessLog = @import("virtual_gateway_file_access_log.zig").VirtualGatewayFileAccessLog;

/// The access log configuration for a virtual gateway.
pub const VirtualGatewayAccessLog = union(enum) {
    /// The file object to send virtual gateway access logs to.
    file: ?VirtualGatewayFileAccessLog,

    pub const json_field_names = .{
        .file = "file",
    };
};
