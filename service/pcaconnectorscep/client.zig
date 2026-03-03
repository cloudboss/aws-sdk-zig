const aws = @import("aws");
const std = @import("std");

const create_challenge = @import("create_challenge.zig");
const create_connector = @import("create_connector.zig");
const delete_challenge = @import("delete_challenge.zig");
const delete_connector = @import("delete_connector.zig");
const get_challenge_metadata = @import("get_challenge_metadata.zig");
const get_challenge_password = @import("get_challenge_password.zig");
const get_connector = @import("get_connector.zig");
const list_challenge_metadata = @import("list_challenge_metadata.zig");
const list_connectors = @import("list_connectors.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Pca Connector Scep";

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

    /// For general-purpose connectors. Creates a *challenge password* for the
    /// specified connector. The SCEP protocol uses a challenge password to
    /// authenticate a request before issuing a certificate from a certificate
    /// authority (CA). Your SCEP clients include the challenge password as part of
    /// their certificate request to Connector for SCEP. To retrieve the connector
    /// Amazon Resource Names (ARNs) for the connectors in your account, call
    /// [ListConnectors](https://docs.aws.amazon.com/C4SCEP_API/pca-connector-scep/latest/APIReference/API_ListConnectors.html).
    ///
    /// To create additional challenge passwords for the connector, call
    /// `CreateChallenge` again. We recommend frequently rotating your challenge
    /// passwords.
    pub fn createChallenge(self: *Self, allocator: std.mem.Allocator, input: create_challenge.CreateChallengeInput, options: create_challenge.Options) !create_challenge.CreateChallengeOutput {
        return create_challenge.execute(self, allocator, input, options);
    }

    /// Creates a SCEP connector. A SCEP connector links Amazon Web Services Private
    /// Certificate Authority to your SCEP-compatible devices and mobile device
    /// management (MDM) systems. Before you create a connector, you must complete a
    /// set of prerequisites, including creation of a private certificate authority
    /// (CA) to use with this connector. For more information, see [Connector for
    /// SCEP
    /// prerequisites](https://docs.aws.amazon.com/privateca/latest/userguide/scep-connector.htmlconnector-for-scep-prerequisites.html).
    pub fn createConnector(self: *Self, allocator: std.mem.Allocator, input: create_connector.CreateConnectorInput, options: create_connector.Options) !create_connector.CreateConnectorOutput {
        return create_connector.execute(self, allocator, input, options);
    }

    /// Deletes the specified
    /// [Challenge](https://docs.aws.amazon.com/C4SCEP_API/pca-connector-scep/latest/APIReference/API_Challenge.html).
    pub fn deleteChallenge(self: *Self, allocator: std.mem.Allocator, input: delete_challenge.DeleteChallengeInput, options: delete_challenge.Options) !delete_challenge.DeleteChallengeOutput {
        return delete_challenge.execute(self, allocator, input, options);
    }

    /// Deletes the specified
    /// [Connector](https://docs.aws.amazon.com/C4SCEP_API/pca-connector-scep/latest/APIReference/API_Connector.html). This operation also deletes any challenges associated with the connector.
    pub fn deleteConnector(self: *Self, allocator: std.mem.Allocator, input: delete_connector.DeleteConnectorInput, options: delete_connector.Options) !delete_connector.DeleteConnectorOutput {
        return delete_connector.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata for the specified
    /// [Challenge](https://docs.aws.amazon.com/C4SCEP_API/pca-connector-scep/latest/APIReference/API_Challenge.html).
    pub fn getChallengeMetadata(self: *Self, allocator: std.mem.Allocator, input: get_challenge_metadata.GetChallengeMetadataInput, options: get_challenge_metadata.Options) !get_challenge_metadata.GetChallengeMetadataOutput {
        return get_challenge_metadata.execute(self, allocator, input, options);
    }

    /// Retrieves the challenge password for the specified
    /// [Challenge](https://docs.aws.amazon.com/C4SCEP_API/pca-connector-scep/latest/APIReference/API_Challenge.html).
    pub fn getChallengePassword(self: *Self, allocator: std.mem.Allocator, input: get_challenge_password.GetChallengePasswordInput, options: get_challenge_password.Options) !get_challenge_password.GetChallengePasswordOutput {
        return get_challenge_password.execute(self, allocator, input, options);
    }

    /// Retrieves details about the specified
    /// [Connector](https://docs.aws.amazon.com/C4SCEP_API/pca-connector-scep/latest/APIReference/API_Connector.html). Calling this action returns important details about the connector, such as the public SCEP URL where your clients can request certificates.
    pub fn getConnector(self: *Self, allocator: std.mem.Allocator, input: get_connector.GetConnectorInput, options: get_connector.Options) !get_connector.GetConnectorOutput {
        return get_connector.execute(self, allocator, input, options);
    }

    /// Retrieves the challenge metadata for the specified ARN.
    pub fn listChallengeMetadata(self: *Self, allocator: std.mem.Allocator, input: list_challenge_metadata.ListChallengeMetadataInput, options: list_challenge_metadata.Options) !list_challenge_metadata.ListChallengeMetadataOutput {
        return list_challenge_metadata.execute(self, allocator, input, options);
    }

    /// Lists the connectors belonging to your Amazon Web Services account.
    pub fn listConnectors(self: *Self, allocator: std.mem.Allocator, input: list_connectors.ListConnectorsInput, options: list_connectors.Options) !list_connectors.ListConnectorsOutput {
        return list_connectors.execute(self, allocator, input, options);
    }

    /// Retrieves the tags associated with the specified resource. Tags are
    /// key-value pairs that
    /// you can use to categorize and manage your resources, for purposes like
    /// billing. For
    /// example, you might set the tag key to "customer" and the value to the
    /// customer name or ID.
    /// You can specify one or more tags to add to each Amazon Web Services
    /// resource, up to 50 tags for a
    /// resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to your resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from your resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listChallengeMetadataPaginator(self: *Self, params: list_challenge_metadata.ListChallengeMetadataInput) paginator.ListChallengeMetadataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConnectorsPaginator(self: *Self, params: list_connectors.ListConnectorsInput) paginator.ListConnectorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
