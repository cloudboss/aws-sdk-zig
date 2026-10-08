const AssetFileContent = @import("asset_file_content.zig").AssetFileContent;
const AssetSourceUrlContent = @import("asset_source_url_content.zig").AssetSourceUrlContent;
const AssetZipContent = @import("asset_zip_content.zig").AssetZipContent;

/// Content for an asset: a single file, a zip bundle, or a source URL to import
/// from
pub const AssetContent = union(enum) {
    /// A single file with path and content
    file: ?AssetFileContent,
    /// A source URL to import asset content from
    source_url: ?AssetSourceUrlContent,
    /// A zip file containing multiple files
    zip: ?AssetZipContent,

    pub const json_field_names = .{
        .file = "file",
        .source_url = "sourceUrl",
        .zip = "zip",
    };
};
