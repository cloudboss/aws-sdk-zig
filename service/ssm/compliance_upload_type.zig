pub const ComplianceUploadType = enum {
    complete,
    partial,

    pub const json_field_names = .{
        .complete = "Complete",
        .partial = "Partial",
    };
};
