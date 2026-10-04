const CodeLocation = @import("code_location.zig").CodeLocation;

/// Union type for identifying an instrumentation configuration by code location
/// or locationHash.
/// Used in Get/Delete/GetStatus operations to allow flexible identification.
pub const LocationIdentifier = union(enum) {
    /// The full code location specification (will be hashed internally)
    code_location: ?CodeLocation,
    /// The pre-computed location hash (16-character hex string)
    location_hash: ?[]const u8,

    pub const json_field_names = .{
        .code_location = "CodeLocation",
        .location_hash = "LocationHash",
    };
};
