const DeobfuscationStatus = @import("deobfuscation_status.zig").DeobfuscationStatus;

/// A structure that contains the configuration for how an app monitor can
/// unminify JavaScript error stack traces using source maps.
pub const JavaScriptSourceMaps = struct {
    /// The S3Uri of the bucket or folder that stores the source map files. It is
    /// required if status is ENABLED.
    s3_uri: ?[]const u8 = null,

    /// Specifies whether JavaScript error stack traces should be unminified for
    /// this app monitor. The default is for JavaScript error stack trace
    /// unminification to be `DISABLED`.
    status: DeobfuscationStatus,

    pub const json_field_names = .{
        .s3_uri = "S3Uri",
        .status = "Status",
    };
};
