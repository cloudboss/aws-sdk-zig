const AssetFileBody = @import("asset_file_body.zig").AssetFileBody;

/// A single file with path and content
pub const AssetFileContent = struct {
    /// The file content
    body: AssetFileBody,

    /// Optional metadata for this file
    metadata: ?[]const u8 = null,

    /// The path of the file within the asset
    path: []const u8,

    pub const json_field_names = .{
        .body = "body",
        .metadata = "metadata",
        .path = "path",
    };
};
