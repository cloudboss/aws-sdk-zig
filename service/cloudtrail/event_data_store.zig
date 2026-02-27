const AdvancedEventSelector = @import("advanced_event_selector.zig").AdvancedEventSelector;
const EventDataStoreStatus = @import("event_data_store_status.zig").EventDataStoreStatus;

/// A storage lake of event data against which you can run complex SQL-based
/// queries. An
/// event data store can include events that you have logged on your account. To
/// select events for an event data
/// store, use [advanced event
/// selectors](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-lake-concepts.html#adv-event-selectors).
pub const EventDataStore = struct {
    /// The advanced event selectors that were used to select
    /// events for the data store.
    advanced_event_selectors: ?[]const AdvancedEventSelector,

    /// The timestamp of the event data store's creation.
    created_timestamp: ?i64,

    /// The ARN of the event data store.
    event_data_store_arn: ?[]const u8,

    /// Indicates whether the event data store includes events
    /// from all Regions, or only from the Region in which it was created.
    multi_region_enabled: ?bool,

    /// The name of the event data store.
    name: ?[]const u8,

    /// Indicates that an event data store is collecting logged
    /// events for an organization.
    organization_enabled: ?bool,

    /// The retention period, in days.
    retention_period: ?i32,

    /// The status of an event data store.
    status: ?EventDataStoreStatus,

    /// Indicates whether the event data store is protected from
    /// termination.
    termination_protection_enabled: ?bool,

    /// The timestamp showing when an event data store was
    /// updated, if applicable. `UpdatedTimestamp` is always either the same or
    /// newer
    /// than the time shown in `CreatedTimestamp`.
    updated_timestamp: ?i64,

    pub const json_field_names = .{
        .advanced_event_selectors = "AdvancedEventSelectors",
        .created_timestamp = "CreatedTimestamp",
        .event_data_store_arn = "EventDataStoreArn",
        .multi_region_enabled = "MultiRegionEnabled",
        .name = "Name",
        .organization_enabled = "OrganizationEnabled",
        .retention_period = "RetentionPeriod",
        .status = "Status",
        .termination_protection_enabled = "TerminationProtectionEnabled",
        .updated_timestamp = "UpdatedTimestamp",
    };
};
