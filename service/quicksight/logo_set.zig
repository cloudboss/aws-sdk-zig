const ImageSet = @import("image_set.zig").ImageSet;

/// A set of logos.
pub const LogoSet = struct {
    /// The favicon logo.
    favicon: ?ImageSet = null,

    /// The primary logo.
    primary: ImageSet,

    pub const json_field_names = .{
        .favicon = "Favicon",
        .primary = "Primary",
    };
};
