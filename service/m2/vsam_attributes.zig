const AlternateKey = @import("alternate_key.zig").AlternateKey;
const PrimaryKey = @import("primary_key.zig").PrimaryKey;

/// The attributes of a VSAM type data set.
pub const VsamAttributes = struct {
    /// The alternate key definitions, if any. A legacy dataset might not have any
    /// alternate key
    /// defined, but if those alternate keys definitions exist, provide them as some
    /// applications
    /// will make use of them.
    alternate_keys: ?[]const AlternateKey = null,

    /// Indicates whether indexes for this dataset are stored as compressed values.
    /// If you have
    /// a large data set (typically > 100 Mb), consider setting this flag to True.
    compressed: bool = false,

    /// The character set used by the data set. Can be ASCII, EBCDIC, or unknown.
    encoding: ?[]const u8 = null,

    /// The record format of the data set.
    format: []const u8,

    /// The primary key of the data set.
    primary_key: ?PrimaryKey = null,

    pub const json_field_names = .{
        .alternate_keys = "alternateKeys",
        .compressed = "compressed",
        .encoding = "encoding",
        .format = "format",
        .primary_key = "primaryKey",
    };
};
