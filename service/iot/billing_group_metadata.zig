/// Additional information about the billing group.
pub const BillingGroupMetadata = struct {
    /// The date the billing group was created.
    creation_date: ?i64 = null,

    pub const json_field_names = .{
        .creation_date = "creationDate",
    };
};
