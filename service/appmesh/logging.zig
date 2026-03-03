const AccessLog = @import("access_log.zig").AccessLog;

/// An object that represents the logging information for a virtual node.
pub const Logging = struct {
    /// The access log configuration for a virtual node.
    access_log: ?AccessLog = null,

    pub const json_field_names = .{
        .access_log = "accessLog",
    };
};
