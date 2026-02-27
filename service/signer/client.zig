const aws = @import("aws");
const std = @import("std");

const add_profile_permission = @import("add_profile_permission.zig");
const cancel_signing_profile = @import("cancel_signing_profile.zig");
const describe_signing_job = @import("describe_signing_job.zig");
const get_revocation_status = @import("get_revocation_status.zig");
const get_signing_platform = @import("get_signing_platform.zig");
const get_signing_profile = @import("get_signing_profile.zig");
const list_profile_permissions = @import("list_profile_permissions.zig");
const list_signing_jobs = @import("list_signing_jobs.zig");
const list_signing_platforms = @import("list_signing_platforms.zig");
const list_signing_profiles = @import("list_signing_profiles.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_signing_profile = @import("put_signing_profile.zig");
const remove_profile_permission = @import("remove_profile_permission.zig");
const revoke_signature = @import("revoke_signature.zig");
const revoke_signing_profile = @import("revoke_signing_profile.zig");
const sign_payload = @import("sign_payload.zig");
const start_signing_job = @import("start_signing_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "signer";

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

    /// Adds cross-account permissions to a signing profile.
    pub fn addProfilePermission(self: *Self, allocator: std.mem.Allocator, input: add_profile_permission.AddProfilePermissionInput, options: add_profile_permission.Options) !add_profile_permission.AddProfilePermissionOutput {
        return add_profile_permission.execute(self, allocator, input, options);
    }

    /// Changes the state of an `ACTIVE` signing profile to `CANCELED`.
    /// A canceled profile is still viewable with the `ListSigningProfiles`
    /// operation, but it cannot perform new signing jobs. See [Data
    /// Retention](https://docs.aws.amazon.com/signer/latest/developerguide/retention.html) for more information on scheduled deletion of a canceled signing profile.
    pub fn cancelSigningProfile(self: *Self, allocator: std.mem.Allocator, input: cancel_signing_profile.CancelSigningProfileInput, options: cancel_signing_profile.Options) !cancel_signing_profile.CancelSigningProfileOutput {
        return cancel_signing_profile.execute(self, allocator, input, options);
    }

    /// Returns information about a specific code signing job. You specify the job
    /// by using the
    /// `jobId` value that is returned by the StartSigningJob
    /// operation.
    pub fn describeSigningJob(self: *Self, allocator: std.mem.Allocator, input: describe_signing_job.DescribeSigningJobInput, options: describe_signing_job.Options) !describe_signing_job.DescribeSigningJobOutput {
        return describe_signing_job.execute(self, allocator, input, options);
    }

    /// Retrieves the revocation status of one or more of the signing profile,
    /// signing job,
    /// and signing certificate.
    pub fn getRevocationStatus(self: *Self, allocator: std.mem.Allocator, input: get_revocation_status.GetRevocationStatusInput, options: get_revocation_status.Options) !get_revocation_status.GetRevocationStatusOutput {
        return get_revocation_status.execute(self, allocator, input, options);
    }

    /// Returns information on a specific signing platform.
    pub fn getSigningPlatform(self: *Self, allocator: std.mem.Allocator, input: get_signing_platform.GetSigningPlatformInput, options: get_signing_platform.Options) !get_signing_platform.GetSigningPlatformOutput {
        return get_signing_platform.execute(self, allocator, input, options);
    }

    /// Returns information on a specific signing profile.
    pub fn getSigningProfile(self: *Self, allocator: std.mem.Allocator, input: get_signing_profile.GetSigningProfileInput, options: get_signing_profile.Options) !get_signing_profile.GetSigningProfileOutput {
        return get_signing_profile.execute(self, allocator, input, options);
    }

    /// Lists the cross-account permissions associated with a signing profile.
    pub fn listProfilePermissions(self: *Self, allocator: std.mem.Allocator, input: list_profile_permissions.ListProfilePermissionsInput, options: list_profile_permissions.Options) !list_profile_permissions.ListProfilePermissionsOutput {
        return list_profile_permissions.execute(self, allocator, input, options);
    }

    /// Lists all your signing jobs. You can use the `maxResults` parameter to limit
    /// the
    /// number of signing jobs that are returned in the response. If additional jobs
    /// remain to
    /// be listed, AWS Signer returns a `nextToken` value. Use this value in
    /// subsequent calls to `ListSigningJobs` to fetch the remaining values. You can
    /// continue calling `ListSigningJobs` with your `maxResults`
    /// parameter and with new values that Signer returns in the `nextToken`
    /// parameter until all of your signing jobs have been returned.
    pub fn listSigningJobs(self: *Self, allocator: std.mem.Allocator, input: list_signing_jobs.ListSigningJobsInput, options: list_signing_jobs.Options) !list_signing_jobs.ListSigningJobsOutput {
        return list_signing_jobs.execute(self, allocator, input, options);
    }

    /// Lists all signing platforms available in AWS Signer that match the request
    /// parameters. If
    /// additional jobs remain to be listed, Signer returns a `nextToken` value.
    /// Use this value in subsequent calls to `ListSigningJobs` to fetch the
    /// remaining values. You can continue calling `ListSigningJobs` with your
    /// `maxResults` parameter and with new values that Signer returns in the
    /// `nextToken` parameter until all of your signing jobs have been
    /// returned.
    pub fn listSigningPlatforms(self: *Self, allocator: std.mem.Allocator, input: list_signing_platforms.ListSigningPlatformsInput, options: list_signing_platforms.Options) !list_signing_platforms.ListSigningPlatformsOutput {
        return list_signing_platforms.execute(self, allocator, input, options);
    }

    /// Lists all available signing profiles in your AWS account. Returns only
    /// profiles with an
    /// `ACTIVE` status unless the `includeCanceled` request field is
    /// set to `true`. If additional jobs remain to be listed, AWS Signer returns a
    /// `nextToken` value. Use this value in subsequent calls to
    /// `ListSigningJobs` to fetch the remaining values. You can continue calling
    /// `ListSigningJobs` with your `maxResults` parameter and with
    /// new values that Signer returns in the `nextToken` parameter until all of
    /// your signing jobs have been returned.
    pub fn listSigningProfiles(self: *Self, allocator: std.mem.Allocator, input: list_signing_profiles.ListSigningProfilesInput, options: list_signing_profiles.Options) !list_signing_profiles.ListSigningProfilesOutput {
        return list_signing_profiles.execute(self, allocator, input, options);
    }

    /// Returns a list of the tags associated with a signing profile resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates a signing profile. A signing profile is a code-signing template that
    /// can be used to
    /// carry out a pre-defined signing job.
    pub fn putSigningProfile(self: *Self, allocator: std.mem.Allocator, input: put_signing_profile.PutSigningProfileInput, options: put_signing_profile.Options) !put_signing_profile.PutSigningProfileOutput {
        return put_signing_profile.execute(self, allocator, input, options);
    }

    /// Removes cross-account permissions from a signing profile.
    pub fn removeProfilePermission(self: *Self, allocator: std.mem.Allocator, input: remove_profile_permission.RemoveProfilePermissionInput, options: remove_profile_permission.Options) !remove_profile_permission.RemoveProfilePermissionOutput {
        return remove_profile_permission.execute(self, allocator, input, options);
    }

    /// Changes the state of a signing job to `REVOKED`. This indicates that the
    /// signature is no
    /// longer valid.
    pub fn revokeSignature(self: *Self, allocator: std.mem.Allocator, input: revoke_signature.RevokeSignatureInput, options: revoke_signature.Options) !revoke_signature.RevokeSignatureOutput {
        return revoke_signature.execute(self, allocator, input, options);
    }

    /// Changes the state of a signing profile to `REVOKED`. This indicates that
    /// signatures
    /// generated using the signing profile after an effective start date are no
    /// longer
    /// valid. A revoked profile is still viewable with the `ListSigningProfiles`
    /// operation, but it cannot perform new signing jobs. See [Data
    /// Retention](https://docs.aws.amazon.com/signer/latest/developerguide/retention.html)
    /// for more information on scheduled deletion of a revoked signing profile.
    pub fn revokeSigningProfile(self: *Self, allocator: std.mem.Allocator, input: revoke_signing_profile.RevokeSigningProfileInput, options: revoke_signing_profile.Options) !revoke_signing_profile.RevokeSigningProfileOutput {
        return revoke_signing_profile.execute(self, allocator, input, options);
    }

    /// Signs a binary payload and returns a signature envelope.
    pub fn signPayload(self: *Self, allocator: std.mem.Allocator, input: sign_payload.SignPayloadInput, options: sign_payload.Options) !sign_payload.SignPayloadOutput {
        return sign_payload.execute(self, allocator, input, options);
    }

    /// Initiates a signing job to be performed on the code provided. Signing jobs
    /// are
    /// viewable by the `ListSigningJobs` operation. Note the following
    /// requirements:
    ///
    /// * You must create an Amazon S3 source bucket. For more information, see
    ///   [Creating a
    ///   Bucket](http://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html) in the
    /// *Amazon S3 Getting Started Guide*.
    ///
    /// * Your S3 source bucket must be version enabled.
    ///
    /// * You must create an S3 destination bucket. AWS Signer uses your S3
    ///   destination bucket to
    /// write your signed code.
    ///
    /// * You specify the name of the source and destination buckets when calling
    ///   the
    /// `StartSigningJob` operation.
    ///
    /// * You must ensure the S3 buckets are from the same Region as the signing
    ///   profile. Cross-Region signing isn't supported.
    ///
    /// * You must also specify a request token that identifies your request to
    ///   Signer.
    ///
    /// You can call the DescribeSigningJob and the ListSigningJobs actions after
    /// you call
    /// `StartSigningJob`.
    ///
    /// For a Java example that shows how to use this action, see
    /// [StartSigningJob](https://docs.aws.amazon.com/signer/latest/developerguide/api-startsigningjob.html).
    pub fn startSigningJob(self: *Self, allocator: std.mem.Allocator, input: start_signing_job.StartSigningJobInput, options: start_signing_job.Options) !start_signing_job.StartSigningJobOutput {
        return start_signing_job.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to a signing profile. Tags are labels that you can use
    /// to
    /// identify and organize your AWS resources. Each tag consists of a key and an
    /// optional
    /// value. To specify the signing profile, use its Amazon Resource Name (ARN).
    /// To specify
    /// the tag, use a key-value pair.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from a signing profile. To remove the tags, specify
    /// a list of
    /// tag keys.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listSigningJobsPaginator(self: *Self, params: list_signing_jobs.ListSigningJobsInput) paginator.ListSigningJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSigningPlatformsPaginator(self: *Self, params: list_signing_platforms.ListSigningPlatformsInput) paginator.ListSigningPlatformsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSigningProfilesPaginator(self: *Self, params: list_signing_profiles.ListSigningProfilesInput) paginator.ListSigningProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilSuccessfulSigningJob(self: *Self, params: describe_signing_job.DescribeSigningJobInput) aws.waiter.WaiterError!void {
        var w = waiters.SuccessfulSigningJobWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
