const QuickConnectContactData = @import("quick_connect_contact_data.zig").QuickConnectContactData;

/// Metadata information for next contact.
pub const NextContactMetadata = union(enum) {
    /// Quick connect contact data for the next contact metadata.
    quick_connect_contact_data: ?QuickConnectContactData,

    pub const json_field_names = .{
        .quick_connect_contact_data = "QuickConnectContactData",
    };
};
