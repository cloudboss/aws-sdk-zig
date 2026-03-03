const FailureCode = @import("failure_code.zig").FailureCode;
const ChangeStatus = @import("change_status.zig").ChangeStatus;

/// A summary of a change set returned in a list of change sets when the
/// `ListChangeSets` action is called.
pub const ChangeSetSummaryListItem = struct {
    /// The ARN associated with the unique identifier for the change set referenced
    /// in this
    /// request.
    change_set_arn: ?[]const u8 = null,

    /// The unique identifier for a change set.
    change_set_id: ?[]const u8 = null,

    /// The non-unique name for the change set.
    change_set_name: ?[]const u8 = null,

    /// The time, in ISO 8601 format (2018-02-27T13:45:22Z), when the change set was
    /// finished.
    end_time: ?[]const u8 = null,

    /// This object is a list of entity IDs (string) that are a part of a change
    /// set. The
    /// entity ID list is a maximum of 20 entities. It must contain at least one
    /// entity.
    entity_id_list: ?[]const []const u8 = null,

    /// Returned if the change set is in `FAILED` status. Can be either
    /// `CLIENT_ERROR`, which means that there are issues with the request (see
    /// the `ErrorDetailList` of `DescribeChangeSet`), or
    /// `SERVER_FAULT`, which means that there is a problem in the system, and
    /// you should retry your request.
    failure_code: ?FailureCode = null,

    /// The time, in ISO 8601 format (2018-02-27T13:45:22Z), when the change set was
    /// started.
    start_time: ?[]const u8 = null,

    /// The current status of the change set.
    status: ?ChangeStatus = null,

    pub const json_field_names = .{
        .change_set_arn = "ChangeSetArn",
        .change_set_id = "ChangeSetId",
        .change_set_name = "ChangeSetName",
        .end_time = "EndTime",
        .entity_id_list = "EntityIdList",
        .failure_code = "FailureCode",
        .start_time = "StartTime",
        .status = "Status",
    };
};
