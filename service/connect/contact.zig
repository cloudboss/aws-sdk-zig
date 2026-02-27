const aws = @import("aws");

const AdditionalEmailRecipients = @import("additional_email_recipients.zig").AdditionalEmailRecipients;
const AgentInfo = @import("agent_info.zig").AgentInfo;
const AnsweringMachineDetectionStatus = @import("answering_machine_detection_status.zig").AnsweringMachineDetectionStatus;
const Campaign = @import("campaign.zig").Campaign;
const Channel = @import("channel.zig").Channel;
const ChatMetrics = @import("chat_metrics.zig").ChatMetrics;
const ContactDetails = @import("contact_details.zig").ContactDetails;
const ContactEvaluation = @import("contact_evaluation.zig").ContactEvaluation;
const Customer = @import("customer.zig").Customer;
const EndpointInfo = @import("endpoint_info.zig").EndpointInfo;
const CustomerVoiceActivity = @import("customer_voice_activity.zig").CustomerVoiceActivity;
const DisconnectDetails = @import("disconnect_details.zig").DisconnectDetails;
const GlobalResiliencyMetadata = @import("global_resiliency_metadata.zig").GlobalResiliencyMetadata;
const ContactInitiationMethod = @import("contact_initiation_method.zig").ContactInitiationMethod;
const NextContactEntry = @import("next_contact_entry.zig").NextContactEntry;
const OutboundStrategy = @import("outbound_strategy.zig").OutboundStrategy;
const QualityMetrics = @import("quality_metrics.zig").QualityMetrics;
const QueueInfo = @import("queue_info.zig").QueueInfo;
const RecordingInfo = @import("recording_info.zig").RecordingInfo;
const RoutingCriteria = @import("routing_criteria.zig").RoutingCriteria;
const SegmentAttributeValue = @import("segment_attribute_value.zig").SegmentAttributeValue;
const TaskTemplateInfoV2 = @import("task_template_info_v2.zig").TaskTemplateInfoV2;
const WisdomInfo = @import("wisdom_info.zig").WisdomInfo;

/// Contains information about a contact.
pub const Contact = struct {
    /// List of additional email addresses for an email contact.
    additional_email_recipients: ?AdditionalEmailRecipients,

    /// Information about the agent who accepted the contact.
    agent_info: ?AgentInfo,

    /// Indicates how an [outbound
    /// campaign](https://docs.aws.amazon.com/connect/latest/adminguide/how-to-create-campaigns.html) call is actually disposed if the contact is connected to Amazon Connect.
    answering_machine_detection_status: ?AnsweringMachineDetectionStatus,

    /// The Amazon Resource Name (ARN) for the contact.
    arn: ?[]const u8,

    /// The attributes of the contact.
    attributes: ?[]const aws.map.StringMapEntry,

    campaign: ?Campaign,

    /// How the contact reached your contact center.
    channel: ?Channel,

    /// Information about how agent, bot, and customer interact in a chat contact.
    chat_metrics: ?ChatMetrics,

    /// The timestamp when customer endpoint connected to Amazon Connect.
    connected_to_system_timestamp: ?i64,

    /// This is the root contactId which is used as a unique identifier for all
    /// subsequent contacts in a contact
    /// tree.
    contact_association_id: ?[]const u8,

    /// A map of string key/value pairs that contain user-defined attributes which
    /// are lightly typed within the contact.
    /// This object is used only for task contacts.
    contact_details: ?ContactDetails,

    /// Information about the contact evaluations where the key is the FormId, which
    /// is a unique identifier for the
    /// form.
    contact_evaluations: ?[]const aws.map.MapEntry(ContactEvaluation),

    /// Information about the Customer on the contact.
    customer: ?Customer,

    /// The customer or external third party participant endpoint.
    customer_endpoint: ?EndpointInfo,

    /// The customer's identification number. For example, the `CustomerId` may be a
    /// customer number from
    /// your CRM. You can create a Lambda function to pull the unique customer ID of
    /// the caller from your CRM system. If you
    /// enable Amazon Connect Voice ID capability, this attribute is populated with
    /// the `CustomerSpeakerId` of
    /// the caller.
    customer_id: ?[]const u8,

    /// Information about customer’s voice activity.
    customer_voice_activity: ?CustomerVoiceActivity,

    /// The description of the contact.
    description: ?[]const u8,

    /// Information about the call disconnect experience.
    disconnect_details: ?DisconnectDetails,

    /// The disconnect reason for the contact. For a list and description of all the
    /// possible disconnect reasons by
    /// channel, see DisconnectReason under
    /// [ContactTraceRecord](https://docs.aws.amazon.com/connect/latest/adminguide/ctr-data-model.html#ctr-ContactTraceRecord) in the
    /// *Amazon Connect Administrator Guide*.
    disconnect_reason: ?[]const u8,

    /// The date and time that the customer endpoint disconnected from the current
    /// contact, in UTC time. In transfer
    /// scenarios, the DisconnectTimestamp of the previous contact indicates the
    /// date and time when that contact
    /// ended.
    disconnect_timestamp: ?i64,

    /// Information about the global resiliency configuration for the contact,
    /// including traffic distribution details.
    global_resiliency_metadata: ?GlobalResiliencyMetadata,

    /// The identifier for the contact.
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
    /// was initiated. For `API`, this is when the request arrived. For
    /// `EXTERNAL_OUTBOUND`, this is
    /// when the agent started dialing the external participant. For `MONITOR`, this
    /// is when the supervisor
    /// started listening to a contact.
    initiation_timestamp: ?i64,

    /// The timestamp when the contact was last paused.
    last_paused_timestamp: ?i64,

    /// The timestamp when the contact was last resumed.
    last_resumed_timestamp: ?i64,

    /// The timestamp when contact was last updated.
    last_update_timestamp: ?i64,

    /// The name of the contact.
    name: ?[]const u8,

    /// List of next contact entries for the contact.
    next_contacts: ?[]const NextContactEntry,

    /// Information about the outbound strategy.
    outbound_strategy: ?OutboundStrategy,

    /// If this contact is not the first contact, this is the ID of the previous
    /// contact.
    previous_contact_id: ?[]const u8,

    /// Information about the quality of the participant's media connection.
    quality_metrics: ?QualityMetrics,

    /// If this contact was queued, this contains information about the queue.
    queue_info: ?QueueInfo,

    /// An integer that represents the queue priority to be applied to the contact
    /// (lower priorities are routed
    /// preferentially). Cannot be specified if the QueueTimeAdjustmentSeconds is
    /// specified. Must be statically defined, must
    /// be larger than zero, and a valid integer value. Default Value is 5.
    queue_priority: ?i64,

    /// An integer that represents the queue time adjust to be applied to the
    /// contact, in seconds (longer / larger queue
    /// time are routed preferentially). Cannot be specified if the QueuePriority is
    /// specified. Must be statically defined
    /// and a valid integer value.
    queue_time_adjustment_seconds: ?i32,

    /// If recording was enabled, this is information about the recordings.
    recordings: ?[]const RecordingInfo,

    /// The contactId that is
    /// [related](https://docs.aws.amazon.com/connect/latest/adminguide/chat-persistence.html#relatedcontactid) to this contact.
    related_contact_id: ?[]const u8,

    /// The timestamp when ringing started for a campaign call.
    ring_start_timestamp: ?i64,

    /// Latest routing criteria on the contact.
    routing_criteria: ?RoutingCriteria,

    /// The timestamp, in Unix epoch time format, at which to start running the
    /// inbound flow.
    scheduled_timestamp: ?i64,

    /// A set of system defined key-value pairs stored on individual contact
    /// segments using an attribute map. The
    /// attributes are standard Amazon Connect attributes and can be accessed in
    /// flows. Attribute keys can include only
    /// alphanumeric, -, and _ characters. This field can be used to show channel
    /// subtype. For example,
    /// `connect:Guide` or `connect:SMS`.
    segment_attributes: ?[]const aws.map.MapEntry(SegmentAttributeValue),

    /// The system endpoint. For `INBOUND`, this is the phone number or email
    /// address that the customer
    /// dialed. For `OUTBOUND` and `EXTERNAL_OUTBOUND`, this is the outbound caller
    /// ID number assigned
    /// to the outbound queue that is used to dial the customer. For callback, this
    /// shows up as Softphone for calls handled
    /// by agents with softphone.
    system_endpoint: ?EndpointInfo,

    /// Tags associated with the contact. This contains both Amazon Web Services
    /// generated and user-defined tags.
    tags: ?[]const aws.map.StringMapEntry,

    /// If this contact was created using a task template, this contains information
    /// about the task template.
    task_template_info: ?TaskTemplateInfoV2,

    /// Total pause count for a contact.
    total_pause_count: ?i32,

    /// Total pause duration for a contact in seconds.
    total_pause_duration_in_seconds: ?i32,

    /// Information about Amazon Connect Wisdom.
    wisdom_info: ?WisdomInfo,

    pub const json_field_names = .{
        .additional_email_recipients = "AdditionalEmailRecipients",
        .agent_info = "AgentInfo",
        .answering_machine_detection_status = "AnsweringMachineDetectionStatus",
        .arn = "Arn",
        .attributes = "Attributes",
        .campaign = "Campaign",
        .channel = "Channel",
        .chat_metrics = "ChatMetrics",
        .connected_to_system_timestamp = "ConnectedToSystemTimestamp",
        .contact_association_id = "ContactAssociationId",
        .contact_details = "ContactDetails",
        .contact_evaluations = "ContactEvaluations",
        .customer = "Customer",
        .customer_endpoint = "CustomerEndpoint",
        .customer_id = "CustomerId",
        .customer_voice_activity = "CustomerVoiceActivity",
        .description = "Description",
        .disconnect_details = "DisconnectDetails",
        .disconnect_reason = "DisconnectReason",
        .disconnect_timestamp = "DisconnectTimestamp",
        .global_resiliency_metadata = "GlobalResiliencyMetadata",
        .id = "Id",
        .initial_contact_id = "InitialContactId",
        .initiation_method = "InitiationMethod",
        .initiation_timestamp = "InitiationTimestamp",
        .last_paused_timestamp = "LastPausedTimestamp",
        .last_resumed_timestamp = "LastResumedTimestamp",
        .last_update_timestamp = "LastUpdateTimestamp",
        .name = "Name",
        .next_contacts = "NextContacts",
        .outbound_strategy = "OutboundStrategy",
        .previous_contact_id = "PreviousContactId",
        .quality_metrics = "QualityMetrics",
        .queue_info = "QueueInfo",
        .queue_priority = "QueuePriority",
        .queue_time_adjustment_seconds = "QueueTimeAdjustmentSeconds",
        .recordings = "Recordings",
        .related_contact_id = "RelatedContactId",
        .ring_start_timestamp = "RingStartTimestamp",
        .routing_criteria = "RoutingCriteria",
        .scheduled_timestamp = "ScheduledTimestamp",
        .segment_attributes = "SegmentAttributes",
        .system_endpoint = "SystemEndpoint",
        .tags = "Tags",
        .task_template_info = "TaskTemplateInfo",
        .total_pause_count = "TotalPauseCount",
        .total_pause_duration_in_seconds = "TotalPauseDurationInSeconds",
        .wisdom_info = "WisdomInfo",
    };
};
