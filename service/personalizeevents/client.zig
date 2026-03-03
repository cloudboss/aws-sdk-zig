const aws = @import("aws");
const std = @import("std");

const put_action_interactions = @import("put_action_interactions.zig");
const put_actions = @import("put_actions.zig");
const put_events = @import("put_events.zig");
const put_items = @import("put_items.zig");
const put_users = @import("put_users.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Personalize Events";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Records action interaction event data. An *action interaction* event is an
    /// interaction between a user and an *action*.
    /// For example, a user taking an action, such a enrolling in a membership
    /// program or downloading your app.
    ///
    /// For more information about recording action interactions, see [Recording
    /// action interaction
    /// events](https://docs.aws.amazon.com/personalize/latest/dg/recording-action-interaction-events.html).
    /// For more information about actions in an Actions dataset, see [Actions
    /// dataset](https://docs.aws.amazon.com/personalize/latest/dg/actions-datasets.html).
    pub fn putActionInteractions(self: *Self, allocator: std.mem.Allocator, input: put_action_interactions.PutActionInteractionsInput, options: CallOptions) !put_action_interactions.PutActionInteractionsOutput {
        return put_action_interactions.execute(self, allocator, input, options);
    }

    /// Adds one or more actions to an Actions dataset. For more information see
    /// [Importing actions
    /// individually](https://docs.aws.amazon.com/personalize/latest/dg/importing-actions.html).
    pub fn putActions(self: *Self, allocator: std.mem.Allocator, input: put_actions.PutActionsInput, options: CallOptions) !put_actions.PutActionsOutput {
        return put_actions.execute(self, allocator, input, options);
    }

    /// Records item interaction event data. For more information see
    /// [Recording item interaction
    /// events](https://docs.aws.amazon.com/personalize/latest/dg/recording-item-interaction-events.html).
    pub fn putEvents(self: *Self, allocator: std.mem.Allocator, input: put_events.PutEventsInput, options: CallOptions) !put_events.PutEventsOutput {
        return put_events.execute(self, allocator, input, options);
    }

    /// Adds one or more items to an Items dataset. For more information see
    /// [Importing items
    /// individually](https://docs.aws.amazon.com/personalize/latest/dg/importing-items.html).
    pub fn putItems(self: *Self, allocator: std.mem.Allocator, input: put_items.PutItemsInput, options: CallOptions) !put_items.PutItemsOutput {
        return put_items.execute(self, allocator, input, options);
    }

    /// Adds one or more users to a Users dataset. For more information see
    /// [Importing users
    /// individually](https://docs.aws.amazon.com/personalize/latest/dg/importing-users.html).
    pub fn putUsers(self: *Self, allocator: std.mem.Allocator, input: put_users.PutUsersInput, options: CallOptions) !put_users.PutUsersOutput {
        return put_users.execute(self, allocator, input, options);
    }
};
