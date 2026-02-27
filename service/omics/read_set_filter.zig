const CreationType = @import("creation_type.zig").CreationType;
const ReadSetStatus = @import("read_set_status.zig").ReadSetStatus;

/// A filter for read sets.
pub const ReadSetFilter = struct {
    /// The filter's start date.
    created_after: ?i64,

    /// The filter's end date.
    created_before: ?i64,

    /// The creation type of the read set.
    creation_type: ?CreationType,

    /// Where the source originated.
    generated_from: ?[]const u8,

    /// A name to filter on.
    name: ?[]const u8,

    /// A genome reference ARN to filter on.
    reference_arn: ?[]const u8,

    /// The read set source's sample ID.
    sample_id: ?[]const u8,

    /// A status to filter on.
    status: ?ReadSetStatus,

    /// The read set source's subject ID.
    subject_id: ?[]const u8,

    pub const json_field_names = .{
        .created_after = "createdAfter",
        .created_before = "createdBefore",
        .creation_type = "creationType",
        .generated_from = "generatedFrom",
        .name = "name",
        .reference_arn = "referenceArn",
        .sample_id = "sampleId",
        .status = "status",
        .subject_id = "subjectId",
    };
};
