/// The [ provisioned
/// mode](https://docs.aws.amazon.com/lambda/latest/dg/invocation-eventsourcemapping.html#invocation-eventsourcemapping-provisioned-mode) configuration for the event source. Use Provisioned Mode to customize the minimum and maximum number of event pollers for your event source.
pub const ProvisionedPollerConfig = struct {
    /// The maximum number of event pollers this event source can scale up to. For
    /// Amazon SQS events source mappings, default is 200, and minimum value allowed
    /// is 2. For Amazon MSK and self-managed Apache Kafka event source mappings,
    /// default is 200, and minimum value allowed is 1.
    maximum_pollers: ?i32 = null,

    /// The minimum number of event pollers this event source can scale down to. For
    /// Amazon SQS events source mappings, default is 2, and minimum 2 required. For
    /// Amazon MSK and self-managed Apache Kafka event source mappings, default is
    /// 1.
    minimum_pollers: ?i32 = null,

    /// (Amazon MSK and self-managed Apache Kafka) The name of the provisioned
    /// poller group. Use this option to group multiple ESMs within the event
    /// source's VPC to share Event Poller Unit (EPU) capacity. You can use this
    /// option to optimize Provisioned mode costs for your ESMs. You can group up to
    /// 100 ESMs per poller group and aggregate maximum pollers across all ESMs in a
    /// group cannot exceed 2000.
    poller_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .maximum_pollers = "MaximumPollers",
        .minimum_pollers = "MinimumPollers",
        .poller_group_name = "PollerGroupName",
    };
};
