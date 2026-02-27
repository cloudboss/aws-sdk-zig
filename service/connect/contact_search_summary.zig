const aws = @import("aws");

const ContactSearchSummaryAgentInfo = @import("contact_search_summary_agent_info.zig").ContactSearchSummaryAgentInfo;
const Channel = @import("channel.zig").Channel;
const GlobalResiliencyMetadata = @import("global_resiliency_metadata.zig").GlobalResiliencyMetadata;
const ContactInitiationMethod = @import("contact_initiation_method.zig").ContactInitiationMethod;
const ContactSearchSummaryQueueInfo = @import("contact_search_summary_queue_info.zig").ContactSearchSummaryQueueInfo;
const RoutingCriteria = @import("routing_criteria.zig").RoutingCriteria;
const ContactSearchSummarySegmentAttributeValue = @import("contact_search_summary_segment_attribute_value.zig").ContactSearchSummarySegmentAttributeValue;

/// Information of returned contact.
pub const ContactSearchSummary = struct {
    /// Information about the agent who accepted the contact.
    agent_info: ?ContactSearchSummaryAgentInfo,

    /// The Amazon Resource Name (ARN) of the contact.
    arn: ?[]const u8,

    /// How the contact reached your contact center.
    channel: ?Channel,

    /// The timestamp when the customer endpoint disconnected from Amazon Connect.
    disconnect_timestamp: ?i64,

    /// Additional routing information for contacts created in ACGR instances.
    global_resiliency_metadata: ?GlobalResiliencyMetadata,

    /// The identifier of the contact summary.
    id: ?[]const u8,

    /// If this contact is related to other contacts, this is the ID of the initial
    /// contact.
    initial_contact_id: ?[]const u8,

    /// Indicates how the contact was initiated.
    initiation_method: ?ContactInitiationMethod,

    /// The date and time this contact was initiated, in UTC time. For `INBOUND`,
    /// this is when the contact
    /// arrived. For `OUTBOUND`, this is when the agent began dialing. For
    /// `CALLBACK`, this is when the
    /// callback contact was created. For `TRANSFER` and `QUEUE_TRANSFER`, this is
    /// when the transfer
    /// was initiated. For API, this is when the request arrived. For
    /// `EXTERNAL_OUTBOUND`, this is when the agent
    /// started dialing the external participant. For `MONITOR`, this is when the
    /// supervisor started listening to
    /// a contact.
    initiation_timestamp: ?i64,

    /// Indicates name of the contact.
    name: ?[]const u8,

    /// If this contact is not the first contact, this is the ID of the previous
    /// contact.
    previous_contact_id: ?[]const u8,

    /// If this contact was queued, this contains information about the queue.
    queue_info: ?ContactSearchSummaryQueueInfo,

    routing_criteria: ?RoutingCriteria,

    /// The timestamp, in Unix epoch time format, at which to start running the
    /// inbound flow.
    scheduled_timestamp: ?i64,

    /// Set of segment attributes for a contact.
    segment_attributes: ?[]const aws.map.MapEntry(ContactSearchSummarySegmentAttributeValue),

    /// Tags associated with the contact. This contains both Amazon Web Services
    /// generated and user-defined tags.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .agent_info = "AgentInfo",
        .arn = "Arn",
        .channel = "Channel",
        .disconnect_timestamp = "DisconnectTimestamp",
        .global_resiliency_metadata = "GlobalResiliencyMetadata",
        .id = "Id",
        .initial_contact_id = "InitialContactId",
        .initiation_method = "InitiationMethod",
        .initiation_timestamp = "InitiationTimestamp",
        .name = "Name",
        .previous_contact_id = "PreviousContactId",
        .queue_info = "QueueInfo",
        .routing_criteria = "RoutingCriteria",
        .scheduled_timestamp = "ScheduledTimestamp",
        .segment_attributes = "SegmentAttributes",
        .tags = "Tags",
    };
};
