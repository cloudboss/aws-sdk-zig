/// Contains copiable `Attributes` structure and wraps information related to
/// specific copy use cases. For example, when copying subsets.
pub const MetadataCopies = struct {
    /// The JSON string used to specify a subset of SOP Instances to copy from
    /// source to destination image set.
    copiable_attributes: []const u8,

    pub const json_field_names = .{
        .copiable_attributes = "copiableAttributes",
    };
};
