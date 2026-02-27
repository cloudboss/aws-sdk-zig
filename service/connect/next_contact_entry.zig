const NextContactMetadata = @import("next_contact_metadata.zig").NextContactMetadata;
const NextContactType = @import("next_contact_type.zig").NextContactType;

/// Entry representing the next contact in a sequence.
pub const NextContactEntry = struct {
    /// Metadata for the next contact entry.
    next_contact_metadata: ?NextContactMetadata,

    /// The type of the next contact entry.
    @"type": ?NextContactType,

    pub const json_field_names = .{
        .next_contact_metadata = "NextContactMetadata",
        .@"type" = "Type",
    };
};
