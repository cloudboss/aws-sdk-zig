const aws = @import("aws");

const AccountEntityAggregate = @import("account_entity_aggregate.zig").AccountEntityAggregate;

/// The aggregate results of entities affected by the specified event in your
/// organization.
/// The results are aggregated by the entity status codes for the specified set
/// of accountsIDs.
pub const OrganizationEntityAggregate = struct {
    /// A list of entity aggregates for each of the specified accounts in your
    /// organization that are affected by
    /// a specific event. If there are no `awsAccountIds` provided in the request,
    /// this field will be empty in the response.
    accounts: ?[]const AccountEntityAggregate = null,

    /// The number of entities for the organization that match the filter criteria
    /// for the specified events.
    count: i32 = 0,

    /// A list of event ARNs (unique identifiers). For example:
    /// `"arn:aws:health:us-east-1::event/EC2/EC2_INSTANCE_RETIREMENT_SCHEDULED/EC2_INSTANCE_RETIREMENT_SCHEDULED_ABC123-CDE456", "arn:aws:health:us-west-1::event/EBS/AWS_EBS_LOST_VOLUME/AWS_EBS_LOST_VOLUME_CHI789_JKL101"`
    event_arn: ?[]const u8 = null,

    /// The number of affected entities aggregated by the entitiy status codes.
    statuses: ?[]const aws.map.MapEntry(i32) = null,

    pub const json_field_names = .{
        .accounts = "accounts",
        .count = "count",
        .event_arn = "eventArn",
        .statuses = "statuses",
    };
};
