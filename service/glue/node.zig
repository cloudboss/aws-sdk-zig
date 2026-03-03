const CrawlerNodeDetails = @import("crawler_node_details.zig").CrawlerNodeDetails;
const JobNodeDetails = @import("job_node_details.zig").JobNodeDetails;
const TriggerNodeDetails = @import("trigger_node_details.zig").TriggerNodeDetails;
const NodeType = @import("node_type.zig").NodeType;

/// A node represents an Glue component (trigger, crawler, or job) on a workflow
/// graph.
pub const Node = struct {
    /// Details of the crawler when the node represents a crawler.
    crawler_details: ?CrawlerNodeDetails = null,

    /// Details of the Job when the node represents a Job.
    job_details: ?JobNodeDetails = null,

    /// The name of the Glue component represented by the node.
    name: ?[]const u8 = null,

    /// Details of the Trigger when the node represents a Trigger.
    trigger_details: ?TriggerNodeDetails = null,

    /// The type of Glue component represented by the node.
    @"type": ?NodeType = null,

    /// The unique Id assigned to the node within the workflow.
    unique_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .crawler_details = "CrawlerDetails",
        .job_details = "JobDetails",
        .name = "Name",
        .trigger_details = "TriggerDetails",
        .@"type" = "Type",
        .unique_id = "UniqueId",
    };
};
