const aws = @import("aws");
const std = @import("std");

const create_investigation_group = @import("create_investigation_group.zig");
const delete_investigation_group = @import("delete_investigation_group.zig");
const delete_investigation_group_policy = @import("delete_investigation_group_policy.zig");
const get_investigation_group = @import("get_investigation_group.zig");
const get_investigation_group_policy = @import("get_investigation_group_policy.zig");
const list_investigation_groups = @import("list_investigation_groups.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_investigation_group_policy = @import("put_investigation_group_policy.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_investigation_group = @import("update_investigation_group.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "AIOps";

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

    /// Creates an *investigation group* in your account. Creating an investigation
    /// group is a one-time setup task for each Region in your account. It is a
    /// necessary task to be able to perform investigations.
    ///
    /// Settings in the investigation group help you centrally manage the common
    /// properties of your investigations, such as the following:
    ///
    /// * Who can access the investigations
    /// * Whether investigation data is encrypted with a customer managed Key
    ///   Management Service key.
    /// * How long investigations and their data are retained by default.
    ///
    /// Currently, you can have one investigation group in each Region in your
    /// account. Each investigation in a Region is a part of the investigation group
    /// in that Region
    ///
    /// To create an investigation group and set up CloudWatch investigations, you
    /// must be signed in to an IAM principal that has either the
    /// `AIOpsConsoleAdminPolicy` or the `AdministratorAccess` IAM policy attached,
    /// or to an account that has similar permissions.
    ///
    /// You can configure CloudWatch alarms to start investigations and add events
    /// to investigations. If you create your investigation group with
    /// `CreateInvestigationGroup` and you want to enable alarms to do this, you
    /// must use `PutInvestigationGroupPolicy` to create a resource policy that
    /// grants this permission to CloudWatch alarms.
    ///
    /// For more information about configuring CloudWatch alarms, see [Using Amazon
    /// CloudWatch
    /// alarms](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html)
    pub fn createInvestigationGroup(self: *Self, allocator: std.mem.Allocator, input: create_investigation_group.CreateInvestigationGroupInput, options: create_investigation_group.Options) !create_investigation_group.CreateInvestigationGroupOutput {
        return create_investigation_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified investigation group from your account. You can
    /// currently have one investigation group per Region in your account. After you
    /// delete an investigation group, you can later create a new investigation
    /// group in the same Region.
    pub fn deleteInvestigationGroup(self: *Self, allocator: std.mem.Allocator, input: delete_investigation_group.DeleteInvestigationGroupInput, options: delete_investigation_group.Options) !delete_investigation_group.DeleteInvestigationGroupOutput {
        return delete_investigation_group.execute(self, allocator, input, options);
    }

    /// Removes the IAM resource policy from being associated with the investigation
    /// group that you specify.
    pub fn deleteInvestigationGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_investigation_group_policy.DeleteInvestigationGroupPolicyInput, options: delete_investigation_group_policy.Options) !delete_investigation_group_policy.DeleteInvestigationGroupPolicyOutput {
        return delete_investigation_group_policy.execute(self, allocator, input, options);
    }

    /// Returns the configuration information for the specified investigation group.
    pub fn getInvestigationGroup(self: *Self, allocator: std.mem.Allocator, input: get_investigation_group.GetInvestigationGroupInput, options: get_investigation_group.Options) !get_investigation_group.GetInvestigationGroupOutput {
        return get_investigation_group.execute(self, allocator, input, options);
    }

    /// Returns the JSON of the IAM resource policy associated with the specified
    /// investigation group in a string. For example,
    /// `{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"aiops.alarms.cloudwatch.amazonaws.com\"},\"Action\":[\"aiops:CreateInvestigation\",\"aiops:CreateInvestigationEvent\"],\"Resource\":\"*\",\"Condition\":{\"StringEquals\":{\"aws:SourceAccount\":\"111122223333\"},\"ArnLike\":{\"aws:SourceArn\":\"arn:aws:cloudwatch:us-east-1:111122223333:alarm:*\"}}}]}`.
    pub fn getInvestigationGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: get_investigation_group_policy.GetInvestigationGroupPolicyInput, options: get_investigation_group_policy.Options) !get_investigation_group_policy.GetInvestigationGroupPolicyOutput {
        return get_investigation_group_policy.execute(self, allocator, input, options);
    }

    /// Returns the ARN and name of each investigation group in the account.
    pub fn listInvestigationGroups(self: *Self, allocator: std.mem.Allocator, input: list_investigation_groups.ListInvestigationGroupsInput, options: list_investigation_groups.Options) !list_investigation_groups.ListInvestigationGroupsOutput {
        return list_investigation_groups.execute(self, allocator, input, options);
    }

    /// Displays the tags associated with a CloudWatch investigations resource.
    /// Currently, investigation groups support tagging.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates an IAM resource policy and assigns it to the specified investigation
    /// group.
    ///
    /// If you create your investigation group with `CreateInvestigationGroup` and
    /// you want to enable CloudWatch alarms to create investigations and add events
    /// to investigations, you must use this operation to create a policy similar to
    /// this example.
    ///
    /// ` { "Version": "2008-10-17", "Statement": [ { "Effect": "Allow",
    /// "Principal": { "Service": "aiops.alarms.cloudwatch.amazonaws.com" },
    /// "Action": [ "aiops:CreateInvestigation", "aiops:CreateInvestigationEvent" ],
    /// "Resource": "*", "Condition": { "StringEquals": { "aws:SourceAccount":
    /// "account-id" }, "ArnLike": { "aws:SourceArn":
    /// "arn:aws:cloudwatch:region:account-id:alarm:*" } } } ] } `
    pub fn putInvestigationGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: put_investigation_group_policy.PutInvestigationGroupPolicyInput, options: put_investigation_group_policy.Options) !put_investigation_group_policy.PutInvestigationGroupPolicyOutput {
        return put_investigation_group_policy.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified resource.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to scope user permissions by granting a user permission to access or
    /// change only resources with certain tag values.
    ///
    /// Tags don't have any semantic meaning to Amazon Web Services and are
    /// interpreted strictly as strings of characters.
    ///
    /// You can associate as many as 50 tags with a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the configuration of the specified investigation group.
    pub fn updateInvestigationGroup(self: *Self, allocator: std.mem.Allocator, input: update_investigation_group.UpdateInvestigationGroupInput, options: update_investigation_group.Options) !update_investigation_group.UpdateInvestigationGroupOutput {
        return update_investigation_group.execute(self, allocator, input, options);
    }

    pub fn listInvestigationGroupsPaginator(self: *Self, params: list_investigation_groups.ListInvestigationGroupsInput) paginator.ListInvestigationGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
