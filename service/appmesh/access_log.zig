const FileAccessLog = @import("file_access_log.zig").FileAccessLog;

/// An object that represents the access logging information for a virtual node.
pub const AccessLog = union(enum) {
    /// The file object to send virtual node access logs to.
    file: ?FileAccessLog,

    pub const json_field_names = .{
        .file = "file",
    };
};
