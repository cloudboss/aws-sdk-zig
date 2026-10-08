const aws = @import("aws");
const std = @import("std");

const associate_feed = @import("associate_feed.zig");
const create_dictionary = @import("create_dictionary.zig");
const create_feed = @import("create_feed.zig");
const delete_dictionary = @import("delete_dictionary.zig");
const delete_feed = @import("delete_feed.zig");
const delete_feed_policy = @import("delete_feed_policy.zig");
const disassociate_feed = @import("disassociate_feed.zig");
const export_dictionary_entries = @import("export_dictionary_entries.zig");
const get_dictionary = @import("get_dictionary.zig");
const get_feed = @import("get_feed.zig");
const get_feed_policy = @import("get_feed_policy.zig");
const get_fixture = @import("get_fixture.zig");
const list_dictionaries = @import("list_dictionaries.zig");
const list_feeds = @import("list_feeds.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_feed_policy = @import("put_feed_policy.zig");
const search_fixtures = @import("search_fixtures.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_dictionary = @import("update_dictionary.zig");
const update_feed = @import("update_feed.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "ElementalInference";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Associates a resource with the feed. The resource provides the input that
    /// Elemental Inference needs in order to perform an Elemental Inference
    /// feature, such as cropping video. You always provide the resource by
    /// associating it with a feed. You can associate only one resource with each
    /// feed. With an association, a specific source media is claiming ownership of
    /// the feed.
    ///
    /// AssociateFeed is a PATCH operation, which means that you can include only
    /// parameters that you want to change. Parameters that you don't include will
    /// not be affected by the operation.
    ///
    /// Specifically:
    ///
    /// * You can add more outputs to the existing outputs. New outputs will be
    ///   appended.
    /// * You can't modify an existing output (for example to change its name).
    ///   Instead, use UpdateFeed.
    /// * You can't delete an existing output. Instead, use UpdateFeed.
    ///
    /// Also note that you can't change the feed name with AssociateFeed. Instead,
    /// use UpdateFeed.
    pub fn associateFeed(self: *Self, allocator: std.mem.Allocator, input: associate_feed.AssociateFeedInput, options: CallOptions) !associate_feed.AssociateFeedOutput {
        return associate_feed.execute(self, allocator, input, options);
    }

    /// Creates a custom dictionary for improving transcription accuracy. A
    /// dictionary contains custom words and phrases that the ASR engine might not
    /// recognize, such as brand names, technical terms, or proper nouns. You can
    /// reference a dictionary when configuring a smart subtitles output.
    pub fn createDictionary(self: *Self, allocator: std.mem.Allocator, input: create_dictionary.CreateDictionaryInput, options: CallOptions) !create_dictionary.CreateDictionaryOutput {
        return create_dictionary.execute(self, allocator, input, options);
    }

    /// Creates a feed. The feed is the target for the live media stream that is
    /// being sent by the calling application. An example of a calling application
    /// is AWS Elemental MediaLive.
    ///
    /// The key contents of the feed is an array of outputs. Each output represents
    /// an Elemental Inference feature. After you create the feed, you must
    /// associate a resource with the feed. At that point, you will have a useable
    /// feed: resource - feed - output or outputs.
    pub fn createFeed(self: *Self, allocator: std.mem.Allocator, input: create_feed.CreateFeedInput, options: CallOptions) !create_feed.CreateFeedOutput {
        return create_feed.execute(self, allocator, input, options);
    }

    /// Deletes the specified dictionary. You cannot delete a dictionary that is
    /// referenced by a feed. You must first remove the dictionary reference from
    /// the feed's subtitling configuration.
    pub fn deleteDictionary(self: *Self, allocator: std.mem.Allocator, input: delete_dictionary.DeleteDictionaryInput, options: CallOptions) !delete_dictionary.DeleteDictionaryOutput {
        return delete_dictionary.execute(self, allocator, input, options);
    }

    /// Deletes the specified feed. You can delete the feed at any time. Elemental
    /// Inference doesn't block you from deleting a feed when the calling
    /// application is calling PutMedia or GetMetadata on that feed, although both
    /// these calls will start to fail. For more information about managing inactive
    /// feeds, see the Elemental Inference User Guide.
    pub fn deleteFeed(self: *Self, allocator: std.mem.Allocator, input: delete_feed.DeleteFeedInput, options: CallOptions) !delete_feed.DeleteFeedOutput {
        return delete_feed.execute(self, allocator, input, options);
    }

    /// Deletes the resource-based policy attached to the specified feed. After you
    /// delete the policy, the operation revokes the cross-account access that the
    /// policy granted.
    pub fn deleteFeedPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_feed_policy.DeleteFeedPolicyInput, options: CallOptions) !delete_feed_policy.DeleteFeedPolicyOutput {
        return delete_feed_policy.execute(self, allocator, input, options);
    }

    /// Releases the resource (the source media) that is associated with this feed.
    /// The outputs in the feed become DISABLED.
    pub fn disassociateFeed(self: *Self, allocator: std.mem.Allocator, input: disassociate_feed.DisassociateFeedInput, options: CallOptions) !disassociate_feed.DisassociateFeedOutput {
        return disassociate_feed.execute(self, allocator, input, options);
    }

    /// Exports the entries from the specified dictionary.
    pub fn exportDictionaryEntries(self: *Self, allocator: std.mem.Allocator, input: export_dictionary_entries.ExportDictionaryEntriesInput, options: CallOptions) !export_dictionary_entries.ExportDictionaryEntriesOutput {
        return export_dictionary_entries.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified dictionary.
    pub fn getDictionary(self: *Self, allocator: std.mem.Allocator, input: get_dictionary.GetDictionaryInput, options: CallOptions) !get_dictionary.GetDictionaryOutput {
        return get_dictionary.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified feed.
    pub fn getFeed(self: *Self, allocator: std.mem.Allocator, input: get_feed.GetFeedInput, options: CallOptions) !get_feed.GetFeedOutput {
        return get_feed.execute(self, allocator, input, options);
    }

    /// Retrieves the resource-based policy attached to the specified feed.
    pub fn getFeedPolicy(self: *Self, allocator: std.mem.Allocator, input: get_feed_policy.GetFeedPolicyInput, options: CallOptions) !get_feed_policy.GetFeedPolicyOutput {
        return get_feed_policy.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified fixture (a sports event, such as a
    /// specific basketball game). You obtain a fixtureId from SearchFixtures, or
    /// from the clipping output of a feed.
    pub fn getFixture(self: *Self, allocator: std.mem.Allocator, input: get_fixture.GetFixtureInput, options: CallOptions) !get_fixture.GetFixtureOutput {
        return get_fixture.execute(self, allocator, input, options);
    }

    /// Lists the dictionaries in your account.
    pub fn listDictionaries(self: *Self, allocator: std.mem.Allocator, input: list_dictionaries.ListDictionariesInput, options: CallOptions) !list_dictionaries.ListDictionariesOutput {
        return list_dictionaries.execute(self, allocator, input, options);
    }

    /// Displays a list of feeds that belong to this AWS account.
    pub fn listFeeds(self: *Self, allocator: std.mem.Allocator, input: list_feeds.ListFeedsInput, options: CallOptions) !list_feeds.ListFeedsOutput {
        return list_feeds.execute(self, allocator, input, options);
    }

    /// List all tags that are on an Elemental Inference resource in the current
    /// region.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Attaches or replaces a resource-based policy on the specified feed. A
    /// resource-based policy grants cross-account access to the feed.
    pub fn putFeedPolicy(self: *Self, allocator: std.mem.Allocator, input: put_feed_policy.PutFeedPolicyInput, options: CallOptions) !put_feed_policy.PutFeedPolicyOutput {
        return put_feed_policy.execute(self, allocator, input, options);
    }

    /// Searches for the fixtures (sports events, such as a specific basketball
    /// game) that are available for a sport in a date window. Each fixture in the
    /// response includes a fixtureId that you specify in the clipping output of a
    /// feed, so that Elemental Inference maps the event data for that fixture onto
    /// the clipping metadata. This operation is paginated: if there are more
    /// fixtures than fit in one page, the response includes a nextToken that you
    /// pass in a subsequent request.
    pub fn searchFixtures(self: *Self, allocator: std.mem.Allocator, input: search_fixtures.SearchFixturesInput, options: CallOptions) !search_fixtures.SearchFixturesOutput {
        return search_fixtures.execute(self, allocator, input, options);
    }

    /// Associates the specified tags to the resource identified by the specified
    /// resourceArn in the current region. If existing tags on a resource are not
    /// specified in the request parameters, they are not changed. When a resource
    /// is deleted, the tags associated with that resource are also deleted.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes specified tags from the specified resource in the current region.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the specified dictionary.
    pub fn updateDictionary(self: *Self, allocator: std.mem.Allocator, input: update_dictionary.UpdateDictionaryInput, options: CallOptions) !update_dictionary.UpdateDictionaryOutput {
        return update_dictionary.execute(self, allocator, input, options);
    }

    /// Updates the name and/or outputs in a feed.
    ///
    /// UpdateFeed is a PUT operation, which means that the payload that you specify
    /// completely overwrites the existing payload.
    ///
    /// This means that if you want to touch the array of outputs, you must pass in
    /// the full new list. So you must omit outputs you want to delete, and include
    /// outputs you want to add or modify.
    ///
    /// If you want to patch the array of outputs to make selective additions, use
    /// AssociateFeed.
    pub fn updateFeed(self: *Self, allocator: std.mem.Allocator, input: update_feed.UpdateFeedInput, options: CallOptions) !update_feed.UpdateFeedOutput {
        return update_feed.execute(self, allocator, input, options);
    }

    pub fn listDictionariesPaginator(self: *Self, params: list_dictionaries.ListDictionariesInput) paginator.ListDictionariesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFeedsPaginator(self: *Self, params: list_feeds.ListFeedsInput) paginator.ListFeedsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchFixturesPaginator(self: *Self, params: search_fixtures.SearchFixturesInput) paginator.SearchFixturesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilFeedDeleted(self: *Self, params: get_feed.GetFeedInput) aws.waiter.WaiterError!void {
        var w = waiters.FeedDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
