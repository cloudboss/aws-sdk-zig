const aws = @import("aws");
const std = @import("std");

const associate_app_block_builder_app_block = @import("associate_app_block_builder_app_block.zig");
const associate_application_fleet = @import("associate_application_fleet.zig");
const associate_application_to_entitlement = @import("associate_application_to_entitlement.zig");
const associate_fleet = @import("associate_fleet.zig");
const associate_software_to_image_builder = @import("associate_software_to_image_builder.zig");
const batch_associate_user_stack = @import("batch_associate_user_stack.zig");
const batch_disassociate_user_stack = @import("batch_disassociate_user_stack.zig");
const copy_image = @import("copy_image.zig");
const create_app_block = @import("create_app_block.zig");
const create_app_block_builder = @import("create_app_block_builder.zig");
const create_app_block_builder_streaming_url = @import("create_app_block_builder_streaming_url.zig");
const create_application = @import("create_application.zig");
const create_directory_config = @import("create_directory_config.zig");
const create_entitlement = @import("create_entitlement.zig");
const create_export_image_task = @import("create_export_image_task.zig");
const create_fleet = @import("create_fleet.zig");
const create_image_builder = @import("create_image_builder.zig");
const create_image_builder_streaming_url = @import("create_image_builder_streaming_url.zig");
const create_imported_image = @import("create_imported_image.zig");
const create_stack = @import("create_stack.zig");
const create_streaming_url = @import("create_streaming_url.zig");
const create_theme_for_stack = @import("create_theme_for_stack.zig");
const create_updated_image = @import("create_updated_image.zig");
const create_usage_report_subscription = @import("create_usage_report_subscription.zig");
const create_user = @import("create_user.zig");
const delete_app_block = @import("delete_app_block.zig");
const delete_app_block_builder = @import("delete_app_block_builder.zig");
const delete_application = @import("delete_application.zig");
const delete_directory_config = @import("delete_directory_config.zig");
const delete_entitlement = @import("delete_entitlement.zig");
const delete_fleet = @import("delete_fleet.zig");
const delete_image = @import("delete_image.zig");
const delete_image_builder = @import("delete_image_builder.zig");
const delete_image_permissions = @import("delete_image_permissions.zig");
const delete_stack = @import("delete_stack.zig");
const delete_theme_for_stack = @import("delete_theme_for_stack.zig");
const delete_usage_report_subscription = @import("delete_usage_report_subscription.zig");
const delete_user = @import("delete_user.zig");
const describe_app_block_builder_app_block_associations = @import("describe_app_block_builder_app_block_associations.zig");
const describe_app_block_builders = @import("describe_app_block_builders.zig");
const describe_app_blocks = @import("describe_app_blocks.zig");
const describe_app_license_usage = @import("describe_app_license_usage.zig");
const describe_application_fleet_associations = @import("describe_application_fleet_associations.zig");
const describe_applications = @import("describe_applications.zig");
const describe_directory_configs = @import("describe_directory_configs.zig");
const describe_entitlements = @import("describe_entitlements.zig");
const describe_fleets = @import("describe_fleets.zig");
const describe_image_builders = @import("describe_image_builders.zig");
const describe_image_permissions = @import("describe_image_permissions.zig");
const describe_images = @import("describe_images.zig");
const describe_sessions = @import("describe_sessions.zig");
const describe_software_associations = @import("describe_software_associations.zig");
const describe_stacks = @import("describe_stacks.zig");
const describe_theme_for_stack = @import("describe_theme_for_stack.zig");
const describe_usage_report_subscriptions = @import("describe_usage_report_subscriptions.zig");
const describe_user_stack_associations = @import("describe_user_stack_associations.zig");
const describe_users = @import("describe_users.zig");
const disable_user = @import("disable_user.zig");
const disassociate_app_block_builder_app_block = @import("disassociate_app_block_builder_app_block.zig");
const disassociate_application_fleet = @import("disassociate_application_fleet.zig");
const disassociate_application_from_entitlement = @import("disassociate_application_from_entitlement.zig");
const disassociate_fleet = @import("disassociate_fleet.zig");
const disassociate_software_from_image_builder = @import("disassociate_software_from_image_builder.zig");
const enable_user = @import("enable_user.zig");
const expire_session = @import("expire_session.zig");
const get_export_image_task = @import("get_export_image_task.zig");
const list_associated_fleets = @import("list_associated_fleets.zig");
const list_associated_stacks = @import("list_associated_stacks.zig");
const list_entitled_applications = @import("list_entitled_applications.zig");
const list_export_image_tasks = @import("list_export_image_tasks.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_app_block_builder = @import("start_app_block_builder.zig");
const start_fleet = @import("start_fleet.zig");
const start_image_builder = @import("start_image_builder.zig");
const start_software_deployment_to_image_builder = @import("start_software_deployment_to_image_builder.zig");
const stop_app_block_builder = @import("stop_app_block_builder.zig");
const stop_fleet = @import("stop_fleet.zig");
const stop_image_builder = @import("stop_image_builder.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_app_block_builder = @import("update_app_block_builder.zig");
const update_application = @import("update_application.zig");
const update_directory_config = @import("update_directory_config.zig");
const update_entitlement = @import("update_entitlement.zig");
const update_fleet = @import("update_fleet.zig");
const update_image_permissions = @import("update_image_permissions.zig");
const update_stack = @import("update_stack.zig");
const update_theme_for_stack = @import("update_theme_for_stack.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "AppStream";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Associates the specified app block builder with the specified app block.
    pub fn associateAppBlockBuilderAppBlock(self: *Self, allocator: std.mem.Allocator, input: associate_app_block_builder_app_block.AssociateAppBlockBuilderAppBlockInput, options: associate_app_block_builder_app_block.Options) !associate_app_block_builder_app_block.AssociateAppBlockBuilderAppBlockOutput {
        return associate_app_block_builder_app_block.execute(self, allocator, input, options);
    }

    /// Associates the specified application with the specified fleet. This is only
    /// supported for Elastic fleets.
    pub fn associateApplicationFleet(self: *Self, allocator: std.mem.Allocator, input: associate_application_fleet.AssociateApplicationFleetInput, options: associate_application_fleet.Options) !associate_application_fleet.AssociateApplicationFleetOutput {
        return associate_application_fleet.execute(self, allocator, input, options);
    }

    /// Associates an application to entitle.
    pub fn associateApplicationToEntitlement(self: *Self, allocator: std.mem.Allocator, input: associate_application_to_entitlement.AssociateApplicationToEntitlementInput, options: associate_application_to_entitlement.Options) !associate_application_to_entitlement.AssociateApplicationToEntitlementOutput {
        return associate_application_to_entitlement.execute(self, allocator, input, options);
    }

    /// Associates the specified fleet with the specified stack.
    pub fn associateFleet(self: *Self, allocator: std.mem.Allocator, input: associate_fleet.AssociateFleetInput, options: associate_fleet.Options) !associate_fleet.AssociateFleetOutput {
        return associate_fleet.execute(self, allocator, input, options);
    }

    /// Associates license included application(s) with an existing image builder
    /// instance.
    pub fn associateSoftwareToImageBuilder(self: *Self, allocator: std.mem.Allocator, input: associate_software_to_image_builder.AssociateSoftwareToImageBuilderInput, options: associate_software_to_image_builder.Options) !associate_software_to_image_builder.AssociateSoftwareToImageBuilderOutput {
        return associate_software_to_image_builder.execute(self, allocator, input, options);
    }

    /// Associates the specified users with the specified stacks. Users in a user
    /// pool cannot be assigned to stacks with fleets that are joined to an Active
    /// Directory domain.
    pub fn batchAssociateUserStack(self: *Self, allocator: std.mem.Allocator, input: batch_associate_user_stack.BatchAssociateUserStackInput, options: batch_associate_user_stack.Options) !batch_associate_user_stack.BatchAssociateUserStackOutput {
        return batch_associate_user_stack.execute(self, allocator, input, options);
    }

    /// Disassociates the specified users from the specified stacks.
    pub fn batchDisassociateUserStack(self: *Self, allocator: std.mem.Allocator, input: batch_disassociate_user_stack.BatchDisassociateUserStackInput, options: batch_disassociate_user_stack.Options) !batch_disassociate_user_stack.BatchDisassociateUserStackOutput {
        return batch_disassociate_user_stack.execute(self, allocator, input, options);
    }

    /// Copies the image within the same region or to a new region within the same
    /// AWS account. Note that any tags you added to the image will not be copied.
    pub fn copyImage(self: *Self, allocator: std.mem.Allocator, input: copy_image.CopyImageInput, options: copy_image.Options) !copy_image.CopyImageOutput {
        return copy_image.execute(self, allocator, input, options);
    }

    /// Creates an app block.
    ///
    /// App blocks are a WorkSpaces Applications resource that stores the details
    /// about the
    /// virtual hard disk in an S3 bucket. It also stores the setup script with
    /// details about
    /// how to mount the virtual hard disk. The virtual hard disk includes the
    /// application
    /// binaries and other files necessary to launch your applications. Multiple
    /// applications
    /// can be assigned to a single app block.
    ///
    /// This is only supported for Elastic fleets.
    pub fn createAppBlock(self: *Self, allocator: std.mem.Allocator, input: create_app_block.CreateAppBlockInput, options: create_app_block.Options) !create_app_block.CreateAppBlockOutput {
        return create_app_block.execute(self, allocator, input, options);
    }

    /// Creates an app block builder.
    pub fn createAppBlockBuilder(self: *Self, allocator: std.mem.Allocator, input: create_app_block_builder.CreateAppBlockBuilderInput, options: create_app_block_builder.Options) !create_app_block_builder.CreateAppBlockBuilderOutput {
        return create_app_block_builder.execute(self, allocator, input, options);
    }

    /// Creates a URL to start a create app block builder streaming session.
    pub fn createAppBlockBuilderStreamingUrl(self: *Self, allocator: std.mem.Allocator, input: create_app_block_builder_streaming_url.CreateAppBlockBuilderStreamingURLInput, options: create_app_block_builder_streaming_url.Options) !create_app_block_builder_streaming_url.CreateAppBlockBuilderStreamingURLOutput {
        return create_app_block_builder_streaming_url.execute(self, allocator, input, options);
    }

    /// Creates an application.
    ///
    /// Applications are a WorkSpaces Applications resource that stores the details
    /// about how to
    /// launch applications on Elastic fleet streaming instances. An application
    /// consists of the
    /// launch details, icon, and display name. Applications are associated with an
    /// app block
    /// that contains the application binaries and other files. The applications
    /// assigned to an
    /// Elastic fleet are the applications users can launch.
    ///
    /// This is only supported for Elastic fleets.
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: create_application.Options) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Creates a Directory Config object in WorkSpaces Applications. This object
    /// includes the configuration information required to join fleets and image
    /// builders to Microsoft Active Directory domains.
    pub fn createDirectoryConfig(self: *Self, allocator: std.mem.Allocator, input: create_directory_config.CreateDirectoryConfigInput, options: create_directory_config.Options) !create_directory_config.CreateDirectoryConfigOutput {
        return create_directory_config.execute(self, allocator, input, options);
    }

    /// Creates a new entitlement. Entitlements control access to specific
    /// applications within
    /// a stack, based on user attributes. Entitlements apply to SAML 2.0 federated
    /// user
    /// identities. WorkSpaces Applications user pool and streaming URL users are
    /// entitled to all
    /// applications in a stack. Entitlements don't apply to the desktop stream view
    /// application, or to applications managed by a dynamic app provider using the
    /// Dynamic
    /// Application Framework.
    pub fn createEntitlement(self: *Self, allocator: std.mem.Allocator, input: create_entitlement.CreateEntitlementInput, options: create_entitlement.Options) !create_entitlement.CreateEntitlementOutput {
        return create_entitlement.execute(self, allocator, input, options);
    }

    /// Creates a task to export a WorkSpaces Applications image to an EC2 AMI. This
    /// allows you to use your customized WorkSpaces Applications images with other
    /// AWS services or for backup purposes.
    pub fn createExportImageTask(self: *Self, allocator: std.mem.Allocator, input: create_export_image_task.CreateExportImageTaskInput, options: create_export_image_task.Options) !create_export_image_task.CreateExportImageTaskOutput {
        return create_export_image_task.execute(self, allocator, input, options);
    }

    /// Creates a fleet. A fleet consists of streaming instances that your users
    /// access for their applications and desktops.
    pub fn createFleet(self: *Self, allocator: std.mem.Allocator, input: create_fleet.CreateFleetInput, options: create_fleet.Options) !create_fleet.CreateFleetOutput {
        return create_fleet.execute(self, allocator, input, options);
    }

    /// Creates an image builder. An image builder is a virtual machine that is used
    /// to create an image.
    ///
    /// The initial state of the builder is `PENDING`. When it is ready, the state
    /// is `RUNNING`.
    pub fn createImageBuilder(self: *Self, allocator: std.mem.Allocator, input: create_image_builder.CreateImageBuilderInput, options: create_image_builder.Options) !create_image_builder.CreateImageBuilderOutput {
        return create_image_builder.execute(self, allocator, input, options);
    }

    /// Creates a URL to start an image builder streaming session.
    pub fn createImageBuilderStreamingUrl(self: *Self, allocator: std.mem.Allocator, input: create_image_builder_streaming_url.CreateImageBuilderStreamingURLInput, options: create_image_builder_streaming_url.Options) !create_image_builder_streaming_url.CreateImageBuilderStreamingURLOutput {
        return create_image_builder_streaming_url.execute(self, allocator, input, options);
    }

    /// Creates a custom WorkSpaces Applications image by importing an EC2 AMI. This
    /// allows you to use your own customized AMI to create WorkSpaces Applications
    /// images that support additional instance types beyond the standard stream.*
    /// instances.
    pub fn createImportedImage(self: *Self, allocator: std.mem.Allocator, input: create_imported_image.CreateImportedImageInput, options: create_imported_image.Options) !create_imported_image.CreateImportedImageOutput {
        return create_imported_image.execute(self, allocator, input, options);
    }

    /// Creates a stack to start streaming applications to users. A stack consists
    /// of an associated fleet, user access policies, and storage configurations.
    pub fn createStack(self: *Self, allocator: std.mem.Allocator, input: create_stack.CreateStackInput, options: create_stack.Options) !create_stack.CreateStackOutput {
        return create_stack.execute(self, allocator, input, options);
    }

    /// Creates a temporary URL to start an WorkSpaces Applications streaming
    /// session for the specified user. A streaming URL enables application
    /// streaming to be tested without user setup.
    pub fn createStreamingUrl(self: *Self, allocator: std.mem.Allocator, input: create_streaming_url.CreateStreamingURLInput, options: create_streaming_url.Options) !create_streaming_url.CreateStreamingURLOutput {
        return create_streaming_url.execute(self, allocator, input, options);
    }

    /// Creates custom branding that customizes the appearance of the streaming
    /// application catalog page.
    pub fn createThemeForStack(self: *Self, allocator: std.mem.Allocator, input: create_theme_for_stack.CreateThemeForStackInput, options: create_theme_for_stack.Options) !create_theme_for_stack.CreateThemeForStackOutput {
        return create_theme_for_stack.execute(self, allocator, input, options);
    }

    /// Creates a new image with the latest Windows operating system updates, driver
    /// updates, and WorkSpaces Applications agent software.
    ///
    /// For more information, see the "Update an Image by Using
    /// Managed WorkSpaces Applications Image Updates" section in [Administer Your
    /// WorkSpaces Applications
    /// Images](https://docs.aws.amazon.com/appstream2/latest/developerguide/administer-images.html), in the *Amazon WorkSpaces Applications Administration Guide*.
    pub fn createUpdatedImage(self: *Self, allocator: std.mem.Allocator, input: create_updated_image.CreateUpdatedImageInput, options: create_updated_image.Options) !create_updated_image.CreateUpdatedImageOutput {
        return create_updated_image.execute(self, allocator, input, options);
    }

    /// Creates a usage report subscription. Usage reports are generated daily.
    pub fn createUsageReportSubscription(self: *Self, allocator: std.mem.Allocator, input: create_usage_report_subscription.CreateUsageReportSubscriptionInput, options: create_usage_report_subscription.Options) !create_usage_report_subscription.CreateUsageReportSubscriptionOutput {
        return create_usage_report_subscription.execute(self, allocator, input, options);
    }

    /// Creates a new user in the user pool.
    pub fn createUser(self: *Self, allocator: std.mem.Allocator, input: create_user.CreateUserInput, options: create_user.Options) !create_user.CreateUserOutput {
        return create_user.execute(self, allocator, input, options);
    }

    /// Deletes an app block.
    pub fn deleteAppBlock(self: *Self, allocator: std.mem.Allocator, input: delete_app_block.DeleteAppBlockInput, options: delete_app_block.Options) !delete_app_block.DeleteAppBlockOutput {
        return delete_app_block.execute(self, allocator, input, options);
    }

    /// Deletes an app block builder.
    ///
    /// An app block builder can only be deleted when it has no association with an
    /// app
    /// block.
    pub fn deleteAppBlockBuilder(self: *Self, allocator: std.mem.Allocator, input: delete_app_block_builder.DeleteAppBlockBuilderInput, options: delete_app_block_builder.Options) !delete_app_block_builder.DeleteAppBlockBuilderOutput {
        return delete_app_block_builder.execute(self, allocator, input, options);
    }

    /// Deletes an application.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: delete_application.Options) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Deletes the specified Directory Config object from WorkSpaces Applications.
    /// This object includes the information required to join streaming instances to
    /// an Active Directory domain.
    pub fn deleteDirectoryConfig(self: *Self, allocator: std.mem.Allocator, input: delete_directory_config.DeleteDirectoryConfigInput, options: delete_directory_config.Options) !delete_directory_config.DeleteDirectoryConfigOutput {
        return delete_directory_config.execute(self, allocator, input, options);
    }

    /// Deletes the specified entitlement.
    pub fn deleteEntitlement(self: *Self, allocator: std.mem.Allocator, input: delete_entitlement.DeleteEntitlementInput, options: delete_entitlement.Options) !delete_entitlement.DeleteEntitlementOutput {
        return delete_entitlement.execute(self, allocator, input, options);
    }

    /// Deletes the specified fleet.
    pub fn deleteFleet(self: *Self, allocator: std.mem.Allocator, input: delete_fleet.DeleteFleetInput, options: delete_fleet.Options) !delete_fleet.DeleteFleetOutput {
        return delete_fleet.execute(self, allocator, input, options);
    }

    /// Deletes the specified image. You cannot delete an image when it is in use.
    /// After you delete an image, you cannot provision new capacity using the
    /// image.
    pub fn deleteImage(self: *Self, allocator: std.mem.Allocator, input: delete_image.DeleteImageInput, options: delete_image.Options) !delete_image.DeleteImageOutput {
        return delete_image.execute(self, allocator, input, options);
    }

    /// Deletes the specified image builder and releases the capacity.
    pub fn deleteImageBuilder(self: *Self, allocator: std.mem.Allocator, input: delete_image_builder.DeleteImageBuilderInput, options: delete_image_builder.Options) !delete_image_builder.DeleteImageBuilderOutput {
        return delete_image_builder.execute(self, allocator, input, options);
    }

    /// Deletes permissions for the specified private image. After you delete
    /// permissions for an image, AWS accounts to which you previously granted these
    /// permissions can no longer use the image.
    pub fn deleteImagePermissions(self: *Self, allocator: std.mem.Allocator, input: delete_image_permissions.DeleteImagePermissionsInput, options: delete_image_permissions.Options) !delete_image_permissions.DeleteImagePermissionsOutput {
        return delete_image_permissions.execute(self, allocator, input, options);
    }

    /// Deletes the specified stack. After the stack is deleted, the application
    /// streaming environment provided by the stack is no longer available to users.
    /// Also, any reservations made for application streaming sessions for the stack
    /// are released.
    pub fn deleteStack(self: *Self, allocator: std.mem.Allocator, input: delete_stack.DeleteStackInput, options: delete_stack.Options) !delete_stack.DeleteStackOutput {
        return delete_stack.execute(self, allocator, input, options);
    }

    /// Deletes custom branding that customizes the appearance of the streaming
    /// application catalog page.
    pub fn deleteThemeForStack(self: *Self, allocator: std.mem.Allocator, input: delete_theme_for_stack.DeleteThemeForStackInput, options: delete_theme_for_stack.Options) !delete_theme_for_stack.DeleteThemeForStackOutput {
        return delete_theme_for_stack.execute(self, allocator, input, options);
    }

    /// Disables usage report generation.
    pub fn deleteUsageReportSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_usage_report_subscription.DeleteUsageReportSubscriptionInput, options: delete_usage_report_subscription.Options) !delete_usage_report_subscription.DeleteUsageReportSubscriptionOutput {
        return delete_usage_report_subscription.execute(self, allocator, input, options);
    }

    /// Deletes a user from the user pool.
    pub fn deleteUser(self: *Self, allocator: std.mem.Allocator, input: delete_user.DeleteUserInput, options: delete_user.Options) !delete_user.DeleteUserOutput {
        return delete_user.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes one or more app block builder associations.
    pub fn describeAppBlockBuilderAppBlockAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_app_block_builder_app_block_associations.DescribeAppBlockBuilderAppBlockAssociationsInput, options: describe_app_block_builder_app_block_associations.Options) !describe_app_block_builder_app_block_associations.DescribeAppBlockBuilderAppBlockAssociationsOutput {
        return describe_app_block_builder_app_block_associations.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes one or more app block builders.
    pub fn describeAppBlockBuilders(self: *Self, allocator: std.mem.Allocator, input: describe_app_block_builders.DescribeAppBlockBuildersInput, options: describe_app_block_builders.Options) !describe_app_block_builders.DescribeAppBlockBuildersOutput {
        return describe_app_block_builders.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes one or more app blocks.
    pub fn describeAppBlocks(self: *Self, allocator: std.mem.Allocator, input: describe_app_blocks.DescribeAppBlocksInput, options: describe_app_blocks.Options) !describe_app_blocks.DescribeAppBlocksOutput {
        return describe_app_blocks.execute(self, allocator, input, options);
    }

    /// Retrieves license included application usage information.
    pub fn describeAppLicenseUsage(self: *Self, allocator: std.mem.Allocator, input: describe_app_license_usage.DescribeAppLicenseUsageInput, options: describe_app_license_usage.Options) !describe_app_license_usage.DescribeAppLicenseUsageOutput {
        return describe_app_license_usage.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes one or more application fleet associations.
    /// Either ApplicationArn or FleetName must be specified.
    pub fn describeApplicationFleetAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_application_fleet_associations.DescribeApplicationFleetAssociationsInput, options: describe_application_fleet_associations.Options) !describe_application_fleet_associations.DescribeApplicationFleetAssociationsOutput {
        return describe_application_fleet_associations.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes one or more applications.
    pub fn describeApplications(self: *Self, allocator: std.mem.Allocator, input: describe_applications.DescribeApplicationsInput, options: describe_applications.Options) !describe_applications.DescribeApplicationsOutput {
        return describe_applications.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes one or more specified Directory Config
    /// objects for WorkSpaces Applications, if the names for these objects are
    /// provided. Otherwise, all Directory Config objects in the account are
    /// described. These objects include the configuration information required to
    /// join fleets and image builders to Microsoft Active Directory domains.
    ///
    /// Although the response syntax in this topic includes the account password,
    /// this password is not returned in the actual response.
    pub fn describeDirectoryConfigs(self: *Self, allocator: std.mem.Allocator, input: describe_directory_configs.DescribeDirectoryConfigsInput, options: describe_directory_configs.Options) !describe_directory_configs.DescribeDirectoryConfigsOutput {
        return describe_directory_configs.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes one of more entitlements.
    pub fn describeEntitlements(self: *Self, allocator: std.mem.Allocator, input: describe_entitlements.DescribeEntitlementsInput, options: describe_entitlements.Options) !describe_entitlements.DescribeEntitlementsOutput {
        return describe_entitlements.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes one or more specified fleets, if the fleet
    /// names are provided. Otherwise, all fleets in the account are described.
    pub fn describeFleets(self: *Self, allocator: std.mem.Allocator, input: describe_fleets.DescribeFleetsInput, options: describe_fleets.Options) !describe_fleets.DescribeFleetsOutput {
        return describe_fleets.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes one or more specified image builders, if the
    /// image builder names are provided. Otherwise, all image builders in the
    /// account are described.
    pub fn describeImageBuilders(self: *Self, allocator: std.mem.Allocator, input: describe_image_builders.DescribeImageBuildersInput, options: describe_image_builders.Options) !describe_image_builders.DescribeImageBuildersOutput {
        return describe_image_builders.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes the permissions for shared AWS account IDs
    /// on a private image that you own.
    pub fn describeImagePermissions(self: *Self, allocator: std.mem.Allocator, input: describe_image_permissions.DescribeImagePermissionsInput, options: describe_image_permissions.Options) !describe_image_permissions.DescribeImagePermissionsOutput {
        return describe_image_permissions.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes one or more specified images, if the image
    /// names or image ARNs are provided. Otherwise, all images in the account are
    /// described.
    pub fn describeImages(self: *Self, allocator: std.mem.Allocator, input: describe_images.DescribeImagesInput, options: describe_images.Options) !describe_images.DescribeImagesOutput {
        return describe_images.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes the streaming sessions for a specified stack
    /// and fleet. If a UserId is provided for the stack and fleet,
    /// only streaming sessions for that user are described. If an authentication
    /// type is not provided,
    /// the default is to authenticate users using a streaming URL.
    pub fn describeSessions(self: *Self, allocator: std.mem.Allocator, input: describe_sessions.DescribeSessionsInput, options: describe_sessions.Options) !describe_sessions.DescribeSessionsOutput {
        return describe_sessions.execute(self, allocator, input, options);
    }

    /// Retrieves license included application associations for a specified
    /// resource.
    pub fn describeSoftwareAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_software_associations.DescribeSoftwareAssociationsInput, options: describe_software_associations.Options) !describe_software_associations.DescribeSoftwareAssociationsOutput {
        return describe_software_associations.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes one or more specified stacks, if the stack
    /// names are provided. Otherwise, all stacks in the account are described.
    pub fn describeStacks(self: *Self, allocator: std.mem.Allocator, input: describe_stacks.DescribeStacksInput, options: describe_stacks.Options) !describe_stacks.DescribeStacksOutput {
        return describe_stacks.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes the theme for a specified stack. A theme is
    /// custom branding that customizes the appearance of the streaming application
    /// catalog page.
    pub fn describeThemeForStack(self: *Self, allocator: std.mem.Allocator, input: describe_theme_for_stack.DescribeThemeForStackInput, options: describe_theme_for_stack.Options) !describe_theme_for_stack.DescribeThemeForStackOutput {
        return describe_theme_for_stack.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes one or more usage report subscriptions.
    pub fn describeUsageReportSubscriptions(self: *Self, allocator: std.mem.Allocator, input: describe_usage_report_subscriptions.DescribeUsageReportSubscriptionsInput, options: describe_usage_report_subscriptions.Options) !describe_usage_report_subscriptions.DescribeUsageReportSubscriptionsOutput {
        return describe_usage_report_subscriptions.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes the UserStackAssociation objects. You must
    /// specify either or both of the following:
    ///
    /// * The stack name
    ///
    /// * The user name (email address of the user associated with the stack) and
    ///   the authentication type for the user
    pub fn describeUserStackAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_user_stack_associations.DescribeUserStackAssociationsInput, options: describe_user_stack_associations.Options) !describe_user_stack_associations.DescribeUserStackAssociationsOutput {
        return describe_user_stack_associations.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes one or more specified users in the user
    /// pool.
    pub fn describeUsers(self: *Self, allocator: std.mem.Allocator, input: describe_users.DescribeUsersInput, options: describe_users.Options) !describe_users.DescribeUsersOutput {
        return describe_users.execute(self, allocator, input, options);
    }

    /// Disables the specified user in the user pool. Users can't sign in to
    /// WorkSpaces Applications until they are re-enabled. This action does not
    /// delete the user.
    pub fn disableUser(self: *Self, allocator: std.mem.Allocator, input: disable_user.DisableUserInput, options: disable_user.Options) !disable_user.DisableUserOutput {
        return disable_user.execute(self, allocator, input, options);
    }

    /// Disassociates a specified app block builder from a specified app block.
    pub fn disassociateAppBlockBuilderAppBlock(self: *Self, allocator: std.mem.Allocator, input: disassociate_app_block_builder_app_block.DisassociateAppBlockBuilderAppBlockInput, options: disassociate_app_block_builder_app_block.Options) !disassociate_app_block_builder_app_block.DisassociateAppBlockBuilderAppBlockOutput {
        return disassociate_app_block_builder_app_block.execute(self, allocator, input, options);
    }

    /// Disassociates the specified application from the fleet.
    pub fn disassociateApplicationFleet(self: *Self, allocator: std.mem.Allocator, input: disassociate_application_fleet.DisassociateApplicationFleetInput, options: disassociate_application_fleet.Options) !disassociate_application_fleet.DisassociateApplicationFleetOutput {
        return disassociate_application_fleet.execute(self, allocator, input, options);
    }

    /// Deletes the specified application from the specified entitlement.
    pub fn disassociateApplicationFromEntitlement(self: *Self, allocator: std.mem.Allocator, input: disassociate_application_from_entitlement.DisassociateApplicationFromEntitlementInput, options: disassociate_application_from_entitlement.Options) !disassociate_application_from_entitlement.DisassociateApplicationFromEntitlementOutput {
        return disassociate_application_from_entitlement.execute(self, allocator, input, options);
    }

    /// Disassociates the specified fleet from the specified stack.
    pub fn disassociateFleet(self: *Self, allocator: std.mem.Allocator, input: disassociate_fleet.DisassociateFleetInput, options: disassociate_fleet.Options) !disassociate_fleet.DisassociateFleetOutput {
        return disassociate_fleet.execute(self, allocator, input, options);
    }

    /// Removes license included application(s) association(s) from an image builder
    /// instance.
    pub fn disassociateSoftwareFromImageBuilder(self: *Self, allocator: std.mem.Allocator, input: disassociate_software_from_image_builder.DisassociateSoftwareFromImageBuilderInput, options: disassociate_software_from_image_builder.Options) !disassociate_software_from_image_builder.DisassociateSoftwareFromImageBuilderOutput {
        return disassociate_software_from_image_builder.execute(self, allocator, input, options);
    }

    /// Enables a user in the user pool. After being enabled, users can sign in to
    /// WorkSpaces Applications and open applications from the stacks to which they
    /// are assigned.
    pub fn enableUser(self: *Self, allocator: std.mem.Allocator, input: enable_user.EnableUserInput, options: enable_user.Options) !enable_user.EnableUserOutput {
        return enable_user.execute(self, allocator, input, options);
    }

    /// Immediately stops the specified streaming session.
    pub fn expireSession(self: *Self, allocator: std.mem.Allocator, input: expire_session.ExpireSessionInput, options: expire_session.Options) !expire_session.ExpireSessionOutput {
        return expire_session.execute(self, allocator, input, options);
    }

    /// Retrieves information about an export image task, including its current
    /// state, progress, and any error details.
    pub fn getExportImageTask(self: *Self, allocator: std.mem.Allocator, input: get_export_image_task.GetExportImageTaskInput, options: get_export_image_task.Options) !get_export_image_task.GetExportImageTaskOutput {
        return get_export_image_task.execute(self, allocator, input, options);
    }

    /// Retrieves the name of the fleet that is associated with the specified stack.
    pub fn listAssociatedFleets(self: *Self, allocator: std.mem.Allocator, input: list_associated_fleets.ListAssociatedFleetsInput, options: list_associated_fleets.Options) !list_associated_fleets.ListAssociatedFleetsOutput {
        return list_associated_fleets.execute(self, allocator, input, options);
    }

    /// Retrieves the name of the stack with which the specified fleet is
    /// associated.
    pub fn listAssociatedStacks(self: *Self, allocator: std.mem.Allocator, input: list_associated_stacks.ListAssociatedStacksInput, options: list_associated_stacks.Options) !list_associated_stacks.ListAssociatedStacksOutput {
        return list_associated_stacks.execute(self, allocator, input, options);
    }

    /// Retrieves a list of entitled applications.
    pub fn listEntitledApplications(self: *Self, allocator: std.mem.Allocator, input: list_entitled_applications.ListEntitledApplicationsInput, options: list_entitled_applications.Options) !list_entitled_applications.ListEntitledApplicationsOutput {
        return list_entitled_applications.execute(self, allocator, input, options);
    }

    /// Lists export image tasks, with optional filtering and pagination. Use this
    /// operation to monitor the status of multiple export operations.
    pub fn listExportImageTasks(self: *Self, allocator: std.mem.Allocator, input: list_export_image_tasks.ListExportImageTasksInput, options: list_export_image_tasks.Options) !list_export_image_tasks.ListExportImageTasksOutput {
        return list_export_image_tasks.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all tags for the specified WorkSpaces Applications
    /// resource. You can tag WorkSpaces Applications image builders, images,
    /// fleets, and stacks.
    ///
    /// For more information about tags, see [Tagging Your
    /// Resources](https://docs.aws.amazon.com/appstream2/latest/developerguide/tagging-basic.html) in the *Amazon WorkSpaces Applications Administration Guide*.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts an app block builder.
    ///
    /// An app block builder can only be started when it's associated with an app
    /// block.
    ///
    /// Starting an app block builder starts a new instance, which is equivalent to
    /// an elastic
    /// fleet instance with application builder assistance functionality.
    pub fn startAppBlockBuilder(self: *Self, allocator: std.mem.Allocator, input: start_app_block_builder.StartAppBlockBuilderInput, options: start_app_block_builder.Options) !start_app_block_builder.StartAppBlockBuilderOutput {
        return start_app_block_builder.execute(self, allocator, input, options);
    }

    /// Starts the specified fleet.
    pub fn startFleet(self: *Self, allocator: std.mem.Allocator, input: start_fleet.StartFleetInput, options: start_fleet.Options) !start_fleet.StartFleetOutput {
        return start_fleet.execute(self, allocator, input, options);
    }

    /// Starts the specified image builder.
    pub fn startImageBuilder(self: *Self, allocator: std.mem.Allocator, input: start_image_builder.StartImageBuilderInput, options: start_image_builder.Options) !start_image_builder.StartImageBuilderOutput {
        return start_image_builder.execute(self, allocator, input, options);
    }

    /// Initiates license included applications deployment to an image builder
    /// instance.
    pub fn startSoftwareDeploymentToImageBuilder(self: *Self, allocator: std.mem.Allocator, input: start_software_deployment_to_image_builder.StartSoftwareDeploymentToImageBuilderInput, options: start_software_deployment_to_image_builder.Options) !start_software_deployment_to_image_builder.StartSoftwareDeploymentToImageBuilderOutput {
        return start_software_deployment_to_image_builder.execute(self, allocator, input, options);
    }

    /// Stops an app block builder.
    ///
    /// Stopping an app block builder terminates the instance, and the instance
    /// state is not
    /// persisted.
    pub fn stopAppBlockBuilder(self: *Self, allocator: std.mem.Allocator, input: stop_app_block_builder.StopAppBlockBuilderInput, options: stop_app_block_builder.Options) !stop_app_block_builder.StopAppBlockBuilderOutput {
        return stop_app_block_builder.execute(self, allocator, input, options);
    }

    /// Stops the specified fleet.
    pub fn stopFleet(self: *Self, allocator: std.mem.Allocator, input: stop_fleet.StopFleetInput, options: stop_fleet.Options) !stop_fleet.StopFleetOutput {
        return stop_fleet.execute(self, allocator, input, options);
    }

    /// Stops the specified image builder.
    pub fn stopImageBuilder(self: *Self, allocator: std.mem.Allocator, input: stop_image_builder.StopImageBuilderInput, options: stop_image_builder.Options) !stop_image_builder.StopImageBuilderOutput {
        return stop_image_builder.execute(self, allocator, input, options);
    }

    /// Adds or overwrites one or more tags for the specified WorkSpaces
    /// Applications resource. You can tag WorkSpaces Applications image builders,
    /// images, fleets, and stacks.
    ///
    /// Each tag consists of a key and an optional value. If a resource already has
    /// a tag with the same key,
    /// this operation updates its value.
    ///
    /// To list the current tags for your resources, use ListTagsForResource.
    /// To disassociate tags from your resources, use UntagResource.
    ///
    /// For more information about tags, see [Tagging Your
    /// Resources](https://docs.aws.amazon.com/appstream2/latest/developerguide/tagging-basic.html) in the *Amazon WorkSpaces Applications Administration Guide*.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Disassociates one or more specified tags from the specified WorkSpaces
    /// Applications resource.
    ///
    /// To list the current tags for your resources, use ListTagsForResource.
    ///
    /// For more information about tags, see [Tagging Your
    /// Resources](https://docs.aws.amazon.com/appstream2/latest/developerguide/tagging-basic.html) in the *Amazon WorkSpaces Applications Administration Guide*.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an app block builder.
    ///
    /// If the app block builder is in the `STARTING` or `STOPPING`
    /// state, you can't update it. If the app block builder is in the `RUNNING`
    /// state, you can only update the DisplayName and Description. If the app block
    /// builder is
    /// in the `STOPPED` state, you can update any attribute except the Name.
    pub fn updateAppBlockBuilder(self: *Self, allocator: std.mem.Allocator, input: update_app_block_builder.UpdateAppBlockBuilderInput, options: update_app_block_builder.Options) !update_app_block_builder.UpdateAppBlockBuilderOutput {
        return update_app_block_builder.execute(self, allocator, input, options);
    }

    /// Updates the specified application.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: update_application.Options) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    /// Updates the specified Directory Config object in WorkSpaces Applications.
    /// This object includes the configuration information required to join fleets
    /// and image builders to Microsoft Active Directory domains.
    pub fn updateDirectoryConfig(self: *Self, allocator: std.mem.Allocator, input: update_directory_config.UpdateDirectoryConfigInput, options: update_directory_config.Options) !update_directory_config.UpdateDirectoryConfigOutput {
        return update_directory_config.execute(self, allocator, input, options);
    }

    /// Updates the specified entitlement.
    pub fn updateEntitlement(self: *Self, allocator: std.mem.Allocator, input: update_entitlement.UpdateEntitlementInput, options: update_entitlement.Options) !update_entitlement.UpdateEntitlementOutput {
        return update_entitlement.execute(self, allocator, input, options);
    }

    /// Updates the specified fleet.
    ///
    /// If the fleet is in the `STOPPED` state, you can update any attribute except
    /// the fleet name.
    ///
    /// If the fleet is in the `RUNNING` state, you can update the following based
    /// on the fleet type:
    ///
    /// * Always-On and On-Demand fleet types
    ///
    /// You can update the `DisplayName`, `ComputeCapacity`,
    /// `ImageARN`, `ImageName`,
    /// `IdleDisconnectTimeoutInSeconds`, and
    /// `DisconnectTimeoutInSeconds` attributes.
    ///
    /// * Elastic fleet type
    ///
    /// You can update the `DisplayName`,
    /// `IdleDisconnectTimeoutInSeconds`,
    /// `DisconnectTimeoutInSeconds`, `MaxConcurrentSessions`,
    /// `SessionScriptS3Location`
    /// and `UsbDeviceFilterStrings` attributes.
    ///
    /// If the fleet is in the `STARTING` or `STOPPED` state, you can't update it.
    pub fn updateFleet(self: *Self, allocator: std.mem.Allocator, input: update_fleet.UpdateFleetInput, options: update_fleet.Options) !update_fleet.UpdateFleetOutput {
        return update_fleet.execute(self, allocator, input, options);
    }

    /// Adds or updates permissions for the specified private image.
    pub fn updateImagePermissions(self: *Self, allocator: std.mem.Allocator, input: update_image_permissions.UpdateImagePermissionsInput, options: update_image_permissions.Options) !update_image_permissions.UpdateImagePermissionsOutput {
        return update_image_permissions.execute(self, allocator, input, options);
    }

    /// Updates the specified fields for the specified stack.
    pub fn updateStack(self: *Self, allocator: std.mem.Allocator, input: update_stack.UpdateStackInput, options: update_stack.Options) !update_stack.UpdateStackOutput {
        return update_stack.execute(self, allocator, input, options);
    }

    /// Updates custom branding that customizes the appearance of the streaming
    /// application catalog page.
    pub fn updateThemeForStack(self: *Self, allocator: std.mem.Allocator, input: update_theme_for_stack.UpdateThemeForStackInput, options: update_theme_for_stack.Options) !update_theme_for_stack.UpdateThemeForStackOutput {
        return update_theme_for_stack.execute(self, allocator, input, options);
    }

    pub fn describeAppBlockBuilderAppBlockAssociationsPaginator(self: *Self, params: describe_app_block_builder_app_block_associations.DescribeAppBlockBuilderAppBlockAssociationsInput) paginator.DescribeAppBlockBuilderAppBlockAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeAppBlockBuildersPaginator(self: *Self, params: describe_app_block_builders.DescribeAppBlockBuildersInput) paginator.DescribeAppBlockBuildersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeImagePermissionsPaginator(self: *Self, params: describe_image_permissions.DescribeImagePermissionsInput) paginator.DescribeImagePermissionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeImagesPaginator(self: *Self, params: describe_images.DescribeImagesInput) paginator.DescribeImagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
