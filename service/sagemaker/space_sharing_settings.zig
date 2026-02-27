const SharingType = @import("sharing_type.zig").SharingType;

/// A collection of space sharing settings.
pub const SpaceSharingSettings = struct {
    /// Specifies the sharing type of the space.
    sharing_type: SharingType,

    pub const json_field_names = .{
        .sharing_type = "SharingType",
    };
};
