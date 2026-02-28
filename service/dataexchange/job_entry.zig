const ResponseDetails = @import("response_details.zig").ResponseDetails;
const JobError = @import("job_error.zig").JobError;
const State = @import("state.zig").State;
const Type = @import("type.zig").Type;

/// AWS Data Exchange Jobs are asynchronous import or export operations used to
/// create or
/// copy assets. A data set owner can both import and export as they see fit.
/// Someone with an
/// entitlement to a data set can only export. Jobs are deleted 90 days after
/// they are
/// created.
pub const JobEntry = struct {
    /// The ARN for the job.
    arn: []const u8,

    /// The date and time that the job was created, in ISO 8601 format.
    created_at: i64,

    /// Details of the operation to be performed by the job, such as export
    /// destination details
    /// or import source details.
    details: ResponseDetails,

    /// Errors for jobs.
    errors: ?[]const JobError,

    /// The unique identifier for the job.
    id: []const u8,

    /// The state of the job.
    state: State,

    /// The job type.
    @"type": Type,

    /// The date and time that the job was last updated, in ISO 8601 format.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .details = "Details",
        .errors = "Errors",
        .id = "Id",
        .state = "State",
        .@"type" = "Type",
        .updated_at = "UpdatedAt",
    };
};
