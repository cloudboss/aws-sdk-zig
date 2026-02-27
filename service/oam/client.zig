const aws = @import("aws");
const std = @import("std");

const create_link = @import("create_link.zig");
const create_sink = @import("create_sink.zig");
const delete_link = @import("delete_link.zig");
const delete_sink = @import("delete_sink.zig");
const get_link = @import("get_link.zig");
const get_sink = @import("get_sink.zig");
const get_sink_policy = @import("get_sink_policy.zig");
const list_attached_links = @import("list_attached_links.zig");
const list_links = @import("list_links.zig");
const list_sinks = @import("list_sinks.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_sink_policy = @import("put_sink_policy.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_link = @import("update_link.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "OAM";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a link between a source account and a sink that you have created in
    /// a monitoring account. After the link is created, data is sent from the
    /// source account to the monitoring account. When you create a link, you can
    /// optionally specify filters that specify which metric namespaces and which
    /// log groups are shared from the source account to the monitoring account.
    ///
    /// Before you create a link, you must create a sink in the monitoring account
    /// and create a sink policy in that account. The sink policy must permit the
    /// source account to link to it. You can grant permission to source accounts by
    /// granting permission to an entire organization or to individual accounts.
    ///
    /// For more information, see
    /// [CreateSink](https://docs.aws.amazon.com/OAM/latest/APIReference/API_CreateSink.html) and [PutSinkPolicy](https://docs.aws.amazon.com/OAM/latest/APIReference/API_PutSinkPolicy.html).
    ///
    /// Each monitoring account can be linked to as many as 100,000 source accounts.
    ///
    /// Each source account can be linked to as many as five monitoring accounts.
    pub fn createLink(self: *Self, allocator: std.mem.Allocator, input: create_link.CreateLinkInput, options: create_link.Options) !create_link.CreateLinkOutput {
        return create_link.execute(self, allocator, input, options);
    }

    /// Use this to create a *sink* in the current account, so that it can be used
    /// as a monitoring account in CloudWatch cross-account observability. A sink is
    /// a resource that represents an attachment point in a monitoring account.
    /// Source accounts can link to the sink to send observability data.
    ///
    /// After you create a sink, you must create a sink policy that allows source
    /// accounts to attach to it. For more information, see
    /// [PutSinkPolicy](https://docs.aws.amazon.com/OAM/latest/APIReference/API_PutSinkPolicy.html).
    ///
    /// Each account can contain one sink per Region. If you delete a sink, you can
    /// then create a new one in that Region.
    pub fn createSink(self: *Self, allocator: std.mem.Allocator, input: create_sink.CreateSinkInput, options: create_sink.Options) !create_sink.CreateSinkOutput {
        return create_sink.execute(self, allocator, input, options);
    }

    /// Deletes a link between a monitoring account sink and a source account. You
    /// must run this operation in the source account.
    pub fn deleteLink(self: *Self, allocator: std.mem.Allocator, input: delete_link.DeleteLinkInput, options: delete_link.Options) !delete_link.DeleteLinkOutput {
        return delete_link.execute(self, allocator, input, options);
    }

    /// Deletes a sink. You must delete all links to a sink before you can delete
    /// that sink.
    pub fn deleteSink(self: *Self, allocator: std.mem.Allocator, input: delete_sink.DeleteSinkInput, options: delete_sink.Options) !delete_sink.DeleteSinkOutput {
        return delete_sink.execute(self, allocator, input, options);
    }

    /// Returns complete information about one link.
    ///
    /// To use this operation, provide the link ARN. To retrieve a list of link
    /// ARNs, use
    /// [ListLinks](https://docs.aws.amazon.com/OAM/latest/APIReference/API_ListLinks.html).
    pub fn getLink(self: *Self, allocator: std.mem.Allocator, input: get_link.GetLinkInput, options: get_link.Options) !get_link.GetLinkOutput {
        return get_link.execute(self, allocator, input, options);
    }

    /// Returns complete information about one monitoring account sink.
    ///
    /// To use this operation, provide the sink ARN. To retrieve a list of sink
    /// ARNs, use
    /// [ListSinks](https://docs.aws.amazon.com/OAM/latest/APIReference/API_ListSinks.html).
    pub fn getSink(self: *Self, allocator: std.mem.Allocator, input: get_sink.GetSinkInput, options: get_sink.Options) !get_sink.GetSinkOutput {
        return get_sink.execute(self, allocator, input, options);
    }

    /// Returns the current sink policy attached to this sink. The sink policy
    /// specifies what accounts can attach to this sink as source accounts, and what
    /// types of data they can share.
    pub fn getSinkPolicy(self: *Self, allocator: std.mem.Allocator, input: get_sink_policy.GetSinkPolicyInput, options: get_sink_policy.Options) !get_sink_policy.GetSinkPolicyOutput {
        return get_sink_policy.execute(self, allocator, input, options);
    }

    /// Returns a list of source account links that are linked to this monitoring
    /// account sink.
    ///
    /// To use this operation, provide the sink ARN. To retrieve a list of sink
    /// ARNs, use
    /// [ListSinks](https://docs.aws.amazon.com/OAM/latest/APIReference/API_ListSinks.html).
    ///
    /// To find a list of links for one source account, use
    /// [ListLinks](https://docs.aws.amazon.com/OAM/latest/APIReference/API_ListLinks.html).
    pub fn listAttachedLinks(self: *Self, allocator: std.mem.Allocator, input: list_attached_links.ListAttachedLinksInput, options: list_attached_links.Options) !list_attached_links.ListAttachedLinksOutput {
        return list_attached_links.execute(self, allocator, input, options);
    }

    /// Use this operation in a source account to return a list of links to
    /// monitoring account sinks that this source account has.
    ///
    /// To find a list of links for one monitoring account sink, use
    /// [ListAttachedLinks](https://docs.aws.amazon.com/OAM/latest/APIReference/API_ListAttachedLinks.html) from within the monitoring account.
    pub fn listLinks(self: *Self, allocator: std.mem.Allocator, input: list_links.ListLinksInput, options: list_links.Options) !list_links.ListLinksOutput {
        return list_links.execute(self, allocator, input, options);
    }

    /// Use this operation in a monitoring account to return the list of sinks
    /// created in that account.
    pub fn listSinks(self: *Self, allocator: std.mem.Allocator, input: list_sinks.ListSinksInput, options: list_sinks.Options) !list_sinks.ListSinksOutput {
        return list_sinks.execute(self, allocator, input, options);
    }

    /// Displays the tags associated with a resource. Both sinks and links support
    /// tagging.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates or updates the resource policy that grants permissions to source
    /// accounts to link to the monitoring account sink. When you create a sink
    /// policy, you can grant permissions to all accounts in an organization or to
    /// individual accounts.
    ///
    /// You can also use a sink policy to limit the types of data that is shared.
    /// The six types of services with their respective resource types that you can
    /// allow or deny are:
    ///
    /// * **Metrics** - Specify with `AWS::CloudWatch::Metric`
    /// * **Log groups** - Specify with `AWS::Logs::LogGroup`
    /// * **Traces** - Specify with `AWS::XRay::Trace`
    /// * **Application Insights - Applications** - Specify with
    ///   `AWS::ApplicationInsights::Application`
    /// * **Internet Monitor** - Specify with `AWS::InternetMonitor::Monitor`
    /// * **Application Signals** - Specify with `AWS::ApplicationSignals::Service`
    ///   and `AWS::ApplicationSignals::ServiceLevelObjective`
    ///
    /// See the examples in this section to see how to specify permitted source
    /// accounts and data types.
    pub fn putSinkPolicy(self: *Self, allocator: std.mem.Allocator, input: put_sink_policy.PutSinkPolicyInput, options: put_sink_policy.Options) !put_sink_policy.PutSinkPolicyOutput {
        return put_sink_policy.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified resource. Both
    /// sinks and links can be tagged.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to scope user permissions by granting a user permission to access or
    /// change only resources with certain tag values.
    ///
    /// Tags don't have any semantic meaning to Amazon Web Services and are
    /// interpreted strictly as strings of characters.
    ///
    /// You can use the `TagResource` action with a resource that already has tags.
    /// If you specify a new tag key for the alarm, this tag is appended to the list
    /// of tags associated with the alarm. If you specify a tag key that is already
    /// associated with the alarm, the new tag value that you specify replaces the
    /// previous value for that tag.
    ///
    /// You can associate as many as 50 tags with a resource.
    ///
    /// Unlike tagging permissions in other Amazon Web Services services, to tag or
    /// untag links and sinks you must have the `oam:ResourceTag` permission. The
    /// `iam:ResourceTag` permission does not allow you to tag and untag links and
    /// sinks.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified resource.
    ///
    /// Unlike tagging permissions in other Amazon Web Services services, to tag or
    /// untag links and sinks you must have the `oam:ResourceTag` permission. The
    /// `iam:TagResource` permission does not allow you to tag and untag links and
    /// sinks.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Use this operation to change what types of data are shared from a source
    /// account to its linked monitoring account sink. You can't change the sink or
    /// change the monitoring account with this operation.
    ///
    /// When you update a link, you can optionally specify filters that specify
    /// which metric namespaces and which log groups are shared from the source
    /// account to the monitoring account.
    ///
    /// To update the list of tags associated with the sink, use
    /// [TagResource](https://docs.aws.amazon.com/OAM/latest/APIReference/API_TagResource.html).
    pub fn updateLink(self: *Self, allocator: std.mem.Allocator, input: update_link.UpdateLinkInput, options: update_link.Options) !update_link.UpdateLinkOutput {
        return update_link.execute(self, allocator, input, options);
    }

    pub fn listAttachedLinksPaginator(self: *Self, params: list_attached_links.ListAttachedLinksInput) paginator.ListAttachedLinksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLinksPaginator(self: *Self, params: list_links.ListLinksInput) paginator.ListLinksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSinksPaginator(self: *Self, params: list_sinks.ListSinksInput) paginator.ListSinksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
