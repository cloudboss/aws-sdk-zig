const aws = @import("aws");
const std = @import("std");

const create_microvm_auth_token = @import("create_microvm_auth_token.zig");
const create_microvm_image = @import("create_microvm_image.zig");
const create_microvm_shell_auth_token = @import("create_microvm_shell_auth_token.zig");
const delete_microvm_image = @import("delete_microvm_image.zig");
const delete_microvm_image_version = @import("delete_microvm_image_version.zig");
const get_microvm = @import("get_microvm.zig");
const get_microvm_image = @import("get_microvm_image.zig");
const get_microvm_image_build = @import("get_microvm_image_build.zig");
const get_microvm_image_version = @import("get_microvm_image_version.zig");
const list_managed_microvm_image_versions = @import("list_managed_microvm_image_versions.zig");
const list_managed_microvm_images = @import("list_managed_microvm_images.zig");
const list_microvm_image_builds = @import("list_microvm_image_builds.zig");
const list_microvm_image_versions = @import("list_microvm_image_versions.zig");
const list_microvm_images = @import("list_microvm_images.zig");
const list_microvms = @import("list_microvms.zig");
const list_tags = @import("list_tags.zig");
const resume_microvm = @import("resume_microvm.zig");
const run_microvm = @import("run_microvm.zig");
const suspend_microvm = @import("suspend_microvm.zig");
const tag_resource = @import("tag_resource.zig");
const terminate_microvm = @import("terminate_microvm.zig");
const untag_resource = @import("untag_resource.zig");
const update_microvm_image = @import("update_microvm_image.zig");
const update_microvm_image_version = @import("update_microvm_image_version.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Lambda Microvms";

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

    /// Creates an authentication token for accessing a running MicroVM. The token
    /// grants access to the specified ports on the MicroVM endpoint.
    pub fn createMicrovmAuthToken(self: *Self, allocator: std.mem.Allocator, input: create_microvm_auth_token.CreateMicrovmAuthTokenInput, options: CallOptions) !create_microvm_auth_token.CreateMicrovmAuthTokenOutput {
        return create_microvm_auth_token.execute(self, allocator, input, options);
    }

    /// Creates a MicroVM image from the specified code artifact and base image. The
    /// build is asynchronous — the image transitions from CREATING to CREATED on
    /// success, or CREATE_FAILED on failure. Use GetMicrovmImage to poll for
    /// completion.
    pub fn createMicrovmImage(self: *Self, allocator: std.mem.Allocator, input: create_microvm_image.CreateMicrovmImageInput, options: CallOptions) !create_microvm_image.CreateMicrovmImageOutput {
        return create_microvm_image.execute(self, allocator, input, options);
    }

    /// Creates a shell authentication token for interactive shell access to a
    /// running MicroVM. The MicroVM must have been run with the SHELL_INGRESS
    /// network connector attached.
    pub fn createMicrovmShellAuthToken(self: *Self, allocator: std.mem.Allocator, input: create_microvm_shell_auth_token.CreateMicrovmShellAuthTokenInput, options: CallOptions) !create_microvm_shell_auth_token.CreateMicrovmShellAuthTokenOutput {
        return create_microvm_shell_auth_token.execute(self, allocator, input, options);
    }

    /// Deletes a MicroVM image. This operation is idempotent; deleting an image
    /// that has already been deleted succeeds without error.
    pub fn deleteMicrovmImage(self: *Self, allocator: std.mem.Allocator, input: delete_microvm_image.DeleteMicrovmImageInput, options: CallOptions) !delete_microvm_image.DeleteMicrovmImageOutput {
        return delete_microvm_image.execute(self, allocator, input, options);
    }

    /// Deletes a specific version of a MicroVM image. This operation is idempotent;
    /// deleting a version that has already been deleted succeeds without error.
    pub fn deleteMicrovmImageVersion(self: *Self, allocator: std.mem.Allocator, input: delete_microvm_image_version.DeleteMicrovmImageVersionInput, options: CallOptions) !delete_microvm_image_version.DeleteMicrovmImageVersionOutput {
        return delete_microvm_image_version.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a specific MicroVM, including its state, endpoint,
    /// image information, and configuration. The state field is eventually
    /// consistent — determine readiness by connecting to the endpoint.
    pub fn getMicrovm(self: *Self, allocator: std.mem.Allocator, input: get_microvm.GetMicrovmInput, options: CallOptions) !get_microvm.GetMicrovmOutput {
        return get_microvm.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a MicroVM image, including its state, versions, and
    /// configuration.
    pub fn getMicrovmImage(self: *Self, allocator: std.mem.Allocator, input: get_microvm_image.GetMicrovmImageInput, options: CallOptions) !get_microvm_image.GetMicrovmImageOutput {
        return get_microvm_image.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a specific MicroVM image build, including its
    /// state, target architecture, and snapshot information.
    pub fn getMicrovmImageBuild(self: *Self, allocator: std.mem.Allocator, input: get_microvm_image_build.GetMicrovmImageBuildInput, options: CallOptions) !get_microvm_image_build.GetMicrovmImageBuildOutput {
        return get_microvm_image_build.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a specific version of a MicroVM image, including
    /// its configuration, state, and build information.
    pub fn getMicrovmImageVersion(self: *Self, allocator: std.mem.Allocator, input: get_microvm_image_version.GetMicrovmImageVersionInput, options: CallOptions) !get_microvm_image_version.GetMicrovmImageVersionOutput {
        return get_microvm_image_version.execute(self, allocator, input, options);
    }

    /// Lists versions of a managed MicroVM image. We recommend using pagination to
    /// ensure that the operation returns quickly and successfully.
    pub fn listManagedMicrovmImageVersions(self: *Self, allocator: std.mem.Allocator, input: list_managed_microvm_image_versions.ListManagedMicrovmImageVersionsInput, options: CallOptions) !list_managed_microvm_image_versions.ListManagedMicrovmImageVersionsOutput {
        return list_managed_microvm_image_versions.execute(self, allocator, input, options);
    }

    /// Lists AWS managed MicroVM images available for use as base images. We
    /// recommend using pagination to ensure that the operation returns quickly and
    /// successfully.
    pub fn listManagedMicrovmImages(self: *Self, allocator: std.mem.Allocator, input: list_managed_microvm_images.ListManagedMicrovmImagesInput, options: CallOptions) !list_managed_microvm_images.ListManagedMicrovmImagesOutput {
        return list_managed_microvm_images.execute(self, allocator, input, options);
    }

    /// Lists builds for a MicroVM image version with optional filtering by
    /// architecture and chipset. We recommend using pagination to ensure that the
    /// operation returns quickly and successfully.
    pub fn listMicrovmImageBuilds(self: *Self, allocator: std.mem.Allocator, input: list_microvm_image_builds.ListMicrovmImageBuildsInput, options: CallOptions) !list_microvm_image_builds.ListMicrovmImageBuildsOutput {
        return list_microvm_image_builds.execute(self, allocator, input, options);
    }

    /// Lists versions of a MicroVM image. We recommend using pagination to ensure
    /// that the operation returns quickly and successfully.
    pub fn listMicrovmImageVersions(self: *Self, allocator: std.mem.Allocator, input: list_microvm_image_versions.ListMicrovmImageVersionsInput, options: CallOptions) !list_microvm_image_versions.ListMicrovmImageVersionsOutput {
        return list_microvm_image_versions.execute(self, allocator, input, options);
    }

    /// Lists MicroVM images in the account with optional name filtering. We
    /// recommend using pagination to ensure that the operation returns quickly and
    /// successfully.
    pub fn listMicrovmImages(self: *Self, allocator: std.mem.Allocator, input: list_microvm_images.ListMicrovmImagesInput, options: CallOptions) !list_microvm_images.ListMicrovmImagesOutput {
        return list_microvm_images.execute(self, allocator, input, options);
    }

    /// Lists MicroVMs in the account with optional filtering by image and version.
    /// We recommend using pagination to ensure that the operation returns quickly
    /// and successfully.
    pub fn listMicrovms(self: *Self, allocator: std.mem.Allocator, input: list_microvms.ListMicrovmsInput, options: CallOptions) !list_microvms.ListMicrovmsOutput {
        return list_microvms.execute(self, allocator, input, options);
    }

    /// Lists the tags associated with a Lambda MicroVM resource.
    pub fn listTags(self: *Self, allocator: std.mem.Allocator, input: list_tags.ListTagsInput, options: CallOptions) !list_tags.ListTagsOutput {
        return list_tags.execute(self, allocator, input, options);
    }

    /// Resumes a suspended MicroVM, restoring it to RUNNING state with all state
    /// intact. The MicroVM must be in SUSPENDED state.
    pub fn resumeMicrovm(self: *Self, allocator: std.mem.Allocator, input: resume_microvm.ResumeMicrovmInput, options: CallOptions) !resume_microvm.ResumeMicrovmOutput {
        return resume_microvm.execute(self, allocator, input, options);
    }

    /// Runs a new MicroVM from the specified image. The MicroVM starts in PENDING
    /// state and transitions to RUNNING once provisioning completes. To connect,
    /// generate an authentication token using CreateMicrovmAuthToken.
    pub fn runMicrovm(self: *Self, allocator: std.mem.Allocator, input: run_microvm.RunMicrovmInput, options: CallOptions) !run_microvm.RunMicrovmOutput {
        return run_microvm.execute(self, allocator, input, options);
    }

    /// Suspends a running MicroVM, preserving its full memory and disk state. The
    /// MicroVM transitions through SUSPENDING to SUSPENDED. To restore, call
    /// ResumeMicrovm or send traffic to the endpoint if autoResumeEnabled is true.
    pub fn suspendMicrovm(self: *Self, allocator: std.mem.Allocator, input: suspend_microvm.SuspendMicrovmInput, options: CallOptions) !suspend_microvm.SuspendMicrovmOutput {
        return suspend_microvm.execute(self, allocator, input, options);
    }

    /// Adds tags to a Lambda MicroVM resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Terminates a MicroVM. This operation is idempotent; terminating a MicroVM
    /// that has already been terminated succeeds without error.
    pub fn terminateMicrovm(self: *Self, allocator: std.mem.Allocator, input: terminate_microvm.TerminateMicrovmInput, options: CallOptions) !terminate_microvm.TerminateMicrovmOutput {
        return terminate_microvm.execute(self, allocator, input, options);
    }

    /// Removes tags from a Lambda MicroVM resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a MicroVM image and triggers a new version
    /// build. This operation uses PUT semantics — all required fields
    /// (codeArtifact, baseImageArn, buildRoleArn) must be provided with every
    /// request.
    pub fn updateMicrovmImage(self: *Self, allocator: std.mem.Allocator, input: update_microvm_image.UpdateMicrovmImageInput, options: CallOptions) !update_microvm_image.UpdateMicrovmImageOutput {
        return update_microvm_image.execute(self, allocator, input, options);
    }

    /// Updates the status of a specific MicroVM image version.
    pub fn updateMicrovmImageVersion(self: *Self, allocator: std.mem.Allocator, input: update_microvm_image_version.UpdateMicrovmImageVersionInput, options: CallOptions) !update_microvm_image_version.UpdateMicrovmImageVersionOutput {
        return update_microvm_image_version.execute(self, allocator, input, options);
    }

    pub fn listManagedMicrovmImageVersionsPaginator(self: *Self, params: list_managed_microvm_image_versions.ListManagedMicrovmImageVersionsInput) paginator.ListManagedMicrovmImageVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listManagedMicrovmImagesPaginator(self: *Self, params: list_managed_microvm_images.ListManagedMicrovmImagesInput) paginator.ListManagedMicrovmImagesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMicrovmImageBuildsPaginator(self: *Self, params: list_microvm_image_builds.ListMicrovmImageBuildsInput) paginator.ListMicrovmImageBuildsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMicrovmImageVersionsPaginator(self: *Self, params: list_microvm_image_versions.ListMicrovmImageVersionsInput) paginator.ListMicrovmImageVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMicrovmImagesPaginator(self: *Self, params: list_microvm_images.ListMicrovmImagesInput) paginator.ListMicrovmImagesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMicrovmsPaginator(self: *Self, params: list_microvms.ListMicrovmsInput) paginator.ListMicrovmsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
