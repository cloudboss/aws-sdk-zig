const CrawlerNodeDetails = @import("crawler_node_details.zig").CrawlerNodeDetails;
const JobNodeDetails = @import("job_node_details.zig").JobNodeDetails;
const TriggerNodeDetails = @import("trigger_node_details.zig").TriggerNodeDetails;
const NodeType = @import("node_type.zig").NodeType;

/// A node represents an Glue component (trigger, crawler, or job) on a workflow
/// graph.
pub const Node = struct {
    /// Details of the crawler when the node represents a crawler.
    crawler_details: ?CrawlerNodeDetails,

    /// Details of the Job when the node represents a Job.
    job_details: ?JobNodeDetails,

    /// The name of the Glue component represented by the node.
    name: ?[]const u8,

    /// Details of the Trigger when the node represents a Trigger.
    trigger_details: ?TriggerNodeDetails,

    /// The type of Glue component represented by the node.
    @"type": ?NodeType,

    /// The unique Id assigned to the node within the workflow.
    unique_id: ?[]const u8,

    pub const json_field_names = .{
        .crawler_details = "CrawlerDetails",
        .job_details = "JobDetails",
        .name = "Name",
        .trigger_details = "TriggerDetails",
        .@"type" = "Type",
        .unique_id = "UniqueId",
    };
};
