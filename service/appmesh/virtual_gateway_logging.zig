const VirtualGatewayAccessLog = @import("virtual_gateway_access_log.zig").VirtualGatewayAccessLog;

/// An object that represents logging information.
pub const VirtualGatewayLogging = struct {
    /// The access log configuration.
    access_log: ?VirtualGatewayAccessLog,

    pub const json_field_names = .{
        .access_log = "accessLog",
    };
};
