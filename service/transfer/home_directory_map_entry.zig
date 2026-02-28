const MapType = @import("map_type.zig").MapType;

/// Represents an object that contains entries and targets for
/// `HomeDirectoryMappings`.
///
/// The following is an `Entry` and `Target` pair example for `chroot`.
///
/// `[ { "Entry": "/", "Target": "/bucket_name/home/mydirectory" } ]`
pub const HomeDirectoryMapEntry = struct {
    /// Represents an entry for `HomeDirectoryMappings`.
    entry: []const u8,

    /// Represents the map target that is used in a `HomeDirectoryMapEntry`.
    target: []const u8,

    /// Specifies the type of mapping. Set the type to `FILE` if you want the
    /// mapping to point to a file, or `DIRECTORY` for the directory to point to a
    /// directory.
    ///
    /// By default, home directory mappings have a `Type` of `DIRECTORY` when you
    /// create a Transfer Family server. You would need to explicitly set `Type` to
    /// `FILE` if you want a mapping to have a file target.
    @"type": ?MapType,

    pub const json_field_names = .{
        .entry = "Entry",
        .target = "Target",
        .@"type" = "Type",
    };
};
