const RegistrationAttachmentFilterName = @import("registration_attachment_filter_name.zig").RegistrationAttachmentFilterName;

/// The filter definition for filtering registration attachments that meets a
/// specified criteria.
pub const RegistrationAttachmentFilter = struct {
    /// The name of the attribute to filter on.
    name: RegistrationAttachmentFilterName,

    /// An array of values to filter on.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
