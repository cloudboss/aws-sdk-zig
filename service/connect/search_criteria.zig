const SearchContactsAdditionalTimeRange = @import("search_contacts_additional_time_range.zig").SearchContactsAdditionalTimeRange;
const AgentHierarchyGroups = @import("agent_hierarchy_groups.zig").AgentHierarchyGroups;
const Channel = @import("channel.zig").Channel;
const ContactAnalysis = @import("contact_analysis.zig").ContactAnalysis;
const ControlPlaneTagFilter = @import("control_plane_tag_filter.zig").ControlPlaneTagFilter;
const ContactInitiationMethod = @import("contact_initiation_method.zig").ContactInitiationMethod;
const NameCriteria = @import("name_criteria.zig").NameCriteria;
const SearchableRoutingCriteria = @import("searchable_routing_criteria.zig").SearchableRoutingCriteria;
const SearchableContactAttributes = @import("searchable_contact_attributes.zig").SearchableContactAttributes;
const SearchableSegmentAttributes = @import("searchable_segment_attributes.zig").SearchableSegmentAttributes;

/// A structure of search criteria to be used to return contacts.
pub const SearchCriteria = struct {
    /// The list of active regions for contacts in ACGR instances.
    active_regions: ?[]const []const u8,

    /// Additional TimeRange used to filter contacts.
    additional_time_range: ?SearchContactsAdditionalTimeRange,

    /// The agent hierarchy groups of the agent at the time of handling the contact.
    agent_hierarchy_groups: ?AgentHierarchyGroups,

    /// The identifiers of agents who handled the contacts.
    agent_ids: ?[]const []const u8,

    /// The list of channels associated with contacts.
    channels: ?[]const Channel,

    /// Search criteria based on analysis outputs from Amazon Connect Contact Lens.
    contact_analysis: ?ContactAnalysis,

    contact_tags: ?ControlPlaneTagFilter,

    /// The list of initiation methods associated with contacts.
    initiation_methods: ?[]const ContactInitiationMethod,

    /// Name of the contact.
    name: ?NameCriteria,

    /// The list of queue IDs associated with contacts.
    queue_ids: ?[]const []const u8,

    /// Routing criteria for the contact.
    routing_criteria: ?SearchableRoutingCriteria,

    /// The search criteria based on user-defined contact attributes that have been
    /// configured for contact search. For
    /// more information, see [Search by custom contact
    /// attributes](https://docs.aws.amazon.com/connect/latest/adminguide/search-custom-attributes.html) in the *Amazon Connect Administrator
    /// Guide*.
    ///
    /// To use `SearchableContactAttributes` in a search request, the
    /// `GetContactAttributes`
    /// action is required to perform an API request. For more information, see
    /// [https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazonconnect.html#amazonconnect-actions-as-permissions](https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazonconnect.html#amazonconnect-actions-as-permissions)Actions
    /// defined by Amazon Connect.
    searchable_contact_attributes: ?SearchableContactAttributes,

    /// The search criteria based on searchable segment attributes of a contact.
    searchable_segment_attributes: ?SearchableSegmentAttributes,

    pub const json_field_names = .{
        .active_regions = "ActiveRegions",
        .additional_time_range = "AdditionalTimeRange",
        .agent_hierarchy_groups = "AgentHierarchyGroups",
        .agent_ids = "AgentIds",
        .channels = "Channels",
        .contact_analysis = "ContactAnalysis",
        .contact_tags = "ContactTags",
        .initiation_methods = "InitiationMethods",
        .name = "Name",
        .queue_ids = "QueueIds",
        .routing_criteria = "RoutingCriteria",
        .searchable_contact_attributes = "SearchableContactAttributes",
        .searchable_segment_attributes = "SearchableSegmentAttributes",
    };
};
