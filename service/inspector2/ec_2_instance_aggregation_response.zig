const aws = @import("aws");

const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// A response that contains the results of a finding aggregation by Amazon EC2
/// instance.
pub const Ec2InstanceAggregationResponse = struct {
    /// The Amazon Web Services account for the Amazon EC2 instance.
    account_id: ?[]const u8,

    /// The Amazon Machine Image (AMI) of the Amazon EC2 instance.
    ami: ?[]const u8,

    /// The Amazon EC2 instance ID.
    instance_id: []const u8,

    /// The tags attached to the instance.
    instance_tags: ?[]const aws.map.StringMapEntry,

    /// The number of network findings for the Amazon EC2 instance.
    network_findings: ?i64,

    /// The operating system of the Amazon EC2 instance.
    operating_system: ?[]const u8,

    /// An object that contains the count of matched findings per severity.
    severity_counts: ?SeverityCounts,

    pub const json_field_names = .{
        .account_id = "accountId",
        .ami = "ami",
        .instance_id = "instanceId",
        .instance_tags = "instanceTags",
        .network_findings = "networkFindings",
        .operating_system = "operatingSystem",
        .severity_counts = "severityCounts",
    };
};
