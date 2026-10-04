const aws = @import("aws");
const std = @import("std");

const cancel_image_creation = @import("cancel_image_creation.zig");
const cancel_lifecycle_execution = @import("cancel_lifecycle_execution.zig");
const create_component = @import("create_component.zig");
const create_container_recipe = @import("create_container_recipe.zig");
const create_distribution_configuration = @import("create_distribution_configuration.zig");
const create_image = @import("create_image.zig");
const create_image_pipeline = @import("create_image_pipeline.zig");
const create_image_recipe = @import("create_image_recipe.zig");
const create_infrastructure_configuration = @import("create_infrastructure_configuration.zig");
const create_lifecycle_policy = @import("create_lifecycle_policy.zig");
const create_workflow = @import("create_workflow.zig");
const delete_component = @import("delete_component.zig");
const delete_container_recipe = @import("delete_container_recipe.zig");
const delete_distribution_configuration = @import("delete_distribution_configuration.zig");
const delete_image = @import("delete_image.zig");
const delete_image_pipeline = @import("delete_image_pipeline.zig");
const delete_image_recipe = @import("delete_image_recipe.zig");
const delete_infrastructure_configuration = @import("delete_infrastructure_configuration.zig");
const delete_lifecycle_policy = @import("delete_lifecycle_policy.zig");
const delete_workflow = @import("delete_workflow.zig");
const distribute_image = @import("distribute_image.zig");
const get_component = @import("get_component.zig");
const get_component_policy = @import("get_component_policy.zig");
const get_container_recipe = @import("get_container_recipe.zig");
const get_container_recipe_policy = @import("get_container_recipe_policy.zig");
const get_distribution_configuration = @import("get_distribution_configuration.zig");
const get_image = @import("get_image.zig");
const get_image_pipeline = @import("get_image_pipeline.zig");
const get_image_policy = @import("get_image_policy.zig");
const get_image_recipe = @import("get_image_recipe.zig");
const get_image_recipe_policy = @import("get_image_recipe_policy.zig");
const get_infrastructure_configuration = @import("get_infrastructure_configuration.zig");
const get_lifecycle_execution = @import("get_lifecycle_execution.zig");
const get_lifecycle_policy = @import("get_lifecycle_policy.zig");
const get_marketplace_resource = @import("get_marketplace_resource.zig");
const get_workflow = @import("get_workflow.zig");
const get_workflow_execution = @import("get_workflow_execution.zig");
const get_workflow_step_execution = @import("get_workflow_step_execution.zig");
const import_component = @import("import_component.zig");
const import_disk_image = @import("import_disk_image.zig");
const import_vm_image = @import("import_vm_image.zig");
const list_component_build_versions = @import("list_component_build_versions.zig");
const list_components = @import("list_components.zig");
const list_container_recipes = @import("list_container_recipes.zig");
const list_distribution_configurations = @import("list_distribution_configurations.zig");
const list_image_build_versions = @import("list_image_build_versions.zig");
const list_image_packages = @import("list_image_packages.zig");
const list_image_pipeline_images = @import("list_image_pipeline_images.zig");
const list_image_pipelines = @import("list_image_pipelines.zig");
const list_image_recipes = @import("list_image_recipes.zig");
const list_image_scan_finding_aggregations = @import("list_image_scan_finding_aggregations.zig");
const list_image_scan_findings = @import("list_image_scan_findings.zig");
const list_images = @import("list_images.zig");
const list_infrastructure_configurations = @import("list_infrastructure_configurations.zig");
const list_lifecycle_execution_resources = @import("list_lifecycle_execution_resources.zig");
const list_lifecycle_executions = @import("list_lifecycle_executions.zig");
const list_lifecycle_policies = @import("list_lifecycle_policies.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_waiting_workflow_steps = @import("list_waiting_workflow_steps.zig");
const list_workflow_build_versions = @import("list_workflow_build_versions.zig");
const list_workflow_executions = @import("list_workflow_executions.zig");
const list_workflow_step_executions = @import("list_workflow_step_executions.zig");
const list_workflows = @import("list_workflows.zig");
const put_component_policy = @import("put_component_policy.zig");
const put_container_recipe_policy = @import("put_container_recipe_policy.zig");
const put_image_policy = @import("put_image_policy.zig");
const put_image_recipe_policy = @import("put_image_recipe_policy.zig");
const retry_image = @import("retry_image.zig");
const send_workflow_step_action = @import("send_workflow_step_action.zig");
const start_image_pipeline_execution = @import("start_image_pipeline_execution.zig");
const start_resource_state_update = @import("start_resource_state_update.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_distribution_configuration = @import("update_distribution_configuration.zig");
const update_image_pipeline = @import("update_image_pipeline.zig");
const update_infrastructure_configuration = @import("update_infrastructure_configuration.zig");
const update_lifecycle_policy = @import("update_lifecycle_policy.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "imagebuilder";

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

    /// Cancels the creation of an image. This operation can only be used on
    /// images in a non-terminal state. Cancellation is asynchronous: the request
    /// returns immediately, then Image Builder stops the running build and moves
    /// the image
    /// to the `CANCELLED` state. Output resources that the build already
    /// created, such as AMIs and snapshots, aren't removed.
    pub fn cancelImageCreation(self: *Self, allocator: std.mem.Allocator, input: cancel_image_creation.CancelImageCreationInput, options: CallOptions) !cancel_image_creation.CancelImageCreationOutput {
        return cancel_image_creation.execute(self, allocator, input, options);
    }

    /// Cancels a lifecycle execution – a single run of lifecycle actions that a
    /// lifecycle policy or a StartResourceStateUpdate request
    /// started. You can only cancel an execution that hasn't reached a
    /// terminal state. Cancellation is asynchronous and doesn't undo
    /// completed lifecycle actions.
    pub fn cancelLifecycleExecution(self: *Self, allocator: std.mem.Allocator, input: cancel_lifecycle_execution.CancelLifecycleExecutionInput, options: CallOptions) !cancel_lifecycle_execution.CancelLifecycleExecutionOutput {
        return cancel_lifecycle_execution.execute(self, allocator, input, options);
    }

    /// Creates a new component that can be used to build, validate, test, and
    /// assess your
    /// image. The component is based on a YAML document that you specify using
    /// exactly one of
    /// the following methods:
    ///
    /// * Inline, using the `data` property in the request body.
    ///
    /// * A URL that points to a YAML document file stored in Amazon S3, using the
    /// `uri` property in the request body.
    ///
    /// Image Builder determines the component type from the document. If the
    /// document
    /// contains a single phase named `test`, the component type is
    /// `TEST`. Otherwise, the component type is `BUILD`.
    pub fn createComponent(self: *Self, allocator: std.mem.Allocator, input: create_component.CreateComponentInput, options: CallOptions) !create_component.CreateComponentOutput {
        return create_component.execute(self, allocator, input, options);
    }

    /// Creates a new container recipe. Container recipes define how images are
    /// configured,
    /// tested, and assessed.
    pub fn createContainerRecipe(self: *Self, allocator: std.mem.Allocator, input: create_container_recipe.CreateContainerRecipeInput, options: CallOptions) !create_container_recipe.CreateContainerRecipeOutput {
        return create_container_recipe.execute(self, allocator, input, options);
    }

    /// Creates a new distribution configuration. Distribution configurations define
    /// and configure the outputs for your images, including the target Regions,
    /// accounts, and settings for each Region.
    pub fn createDistributionConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_distribution_configuration.CreateDistributionConfigurationInput, options: CallOptions) !create_distribution_configuration.CreateDistributionConfigurationOutput {
        return create_distribution_configuration.execute(self, allocator, input, options);
    }

    /// Creates a new image along with all configured output resources defined in
    /// the
    /// distribution configuration. You must specify exactly one recipe for your
    /// image, using
    /// either a `containerRecipeArn` or an `imageRecipeArn`.
    ///
    /// The response returns as soon as Image Builder creates the new image
    /// resource.
    /// The image build process runs asynchronously. To check its progress, call
    /// [GetImage](https://docs.aws.amazon.com/imagebuilder/latest/APIReference/API_GetImage.html) and check the image status.
    pub fn createImage(self: *Self, allocator: std.mem.Allocator, input: create_image.CreateImageInput, options: CallOptions) !create_image.CreateImageOutput {
        return create_image.execute(self, allocator, input, options);
    }

    /// Creates a new image pipeline. Use image pipelines to automate the creation
    /// and
    /// distribution of images. You must specify exactly one recipe for the
    /// pipeline,
    /// using either a `containerRecipeArn` or an
    /// `imageRecipeArn`.
    pub fn createImagePipeline(self: *Self, allocator: std.mem.Allocator, input: create_image_pipeline.CreateImagePipelineInput, options: CallOptions) !create_image_pipeline.CreateImagePipelineOutput {
        return create_image_pipeline.execute(self, allocator, input, options);
    }

    /// Creates a new image recipe. Image recipes define how images are configured,
    /// tested,
    /// and assessed.
    pub fn createImageRecipe(self: *Self, allocator: std.mem.Allocator, input: create_image_recipe.CreateImageRecipeInput, options: CallOptions) !create_image_recipe.CreateImageRecipeOutput {
        return create_image_recipe.execute(self, allocator, input, options);
    }

    /// Creates a new infrastructure configuration. An infrastructure configuration
    /// defines
    /// the environment in which your image will be built and tested.
    pub fn createInfrastructureConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_infrastructure_configuration.CreateInfrastructureConfigurationInput, options: CallOptions) !create_infrastructure_configuration.CreateInfrastructureConfigurationOutput {
        return create_infrastructure_configuration.execute(self, allocator, input, options);
    }

    /// Creates a lifecycle policy resource.
    pub fn createLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: create_lifecycle_policy.CreateLifecyclePolicyInput, options: CallOptions) !create_lifecycle_policy.CreateLifecyclePolicyOutput {
        return create_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Creates a new workflow or a new version of an existing workflow. If a
    /// workflow
    /// with the same name and semantic version already exists, and your request
    /// changes
    /// its configuration, Image Builder creates a new build version.
    /// If the configuration is identical to the latest build version, the request
    /// fails because that workflow configuration already exists.
    pub fn createWorkflow(self: *Self, allocator: std.mem.Allocator, input: create_workflow.CreateWorkflowInput, options: CallOptions) !create_workflow.CreateWorkflowOutput {
        return create_workflow.execute(self, allocator, input, options);
    }

    /// Deletes a component build version. The request fails with
    /// `ResourceDependencyException` if an image recipe or container
    /// recipe references this component version. It also fails if the component
    /// build version is shared with other accounts.
    pub fn deleteComponent(self: *Self, allocator: std.mem.Allocator, input: delete_component.DeleteComponentInput, options: CallOptions) !delete_component.DeleteComponentOutput {
        return delete_component.execute(self, allocator, input, options);
    }

    /// Deletes a container recipe. The request fails with
    /// `ResourceDependencyException` if the recipe is shared with other
    /// accounts, or if an image pipeline references it.
    pub fn deleteContainerRecipe(self: *Self, allocator: std.mem.Allocator, input: delete_container_recipe.DeleteContainerRecipeInput, options: CallOptions) !delete_container_recipe.DeleteContainerRecipeOutput {
        return delete_container_recipe.execute(self, allocator, input, options);
    }

    /// Deletes a distribution configuration. You can't delete a configuration
    /// that an image pipeline still references. The request fails with
    /// `ResourceDependencyException`. Update or delete the referencing
    /// pipelines first.
    pub fn deleteDistributionConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_distribution_configuration.DeleteDistributionConfigurationInput, options: CallOptions) !delete_distribution_configuration.DeleteDistributionConfigurationOutput {
        return delete_distribution_configuration.execute(self, allocator, input, options);
    }

    /// Deletes an Image Builder image resource. This does not delete any EC2 AMIs
    /// or ECR container
    /// images that are created during the image build process. You must clean those
    /// up
    /// separately, using the appropriate Amazon EC2 or Amazon ECR console actions,
    /// or API or CLI
    /// commands.
    ///
    /// The request fails with `ResourceDependencyException` if the image
    /// is shared with other accounts, or if other resources depend on it. It also
    /// fails while the image build is still running. Cancel an in-progress build
    /// with CancelImageCreation before you delete the image.
    ///
    /// * To deregister an EC2 Linux AMI, see [Deregister your
    /// Linux
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/deregister-ami.html) in the *
    /// Amazon EC2 User Guide*
    /// .
    ///
    /// * To deregister an EC2 Windows AMI, see [Deregister your
    /// Windows
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/deregister-ami.html) in the *
    /// Amazon EC2 Windows Guide*
    /// .
    ///
    /// * To delete a container image from Amazon ECR, see [Deleting
    /// an
    /// image](https://docs.aws.amazon.com/AmazonECR/latest/userguide/delete_image.html) in the *Amazon ECR User Guide*.
    pub fn deleteImage(self: *Self, allocator: std.mem.Allocator, input: delete_image.DeleteImageInput, options: CallOptions) !delete_image.DeleteImageOutput {
        return delete_image.execute(self, allocator, input, options);
    }

    /// Deletes an image pipeline. Images that the pipeline created aren't
    /// deleted - remove those separately with DeleteImage. You
    /// can delete a pipeline while a build that it started is still running. The
    /// build continues independently.
    pub fn deleteImagePipeline(self: *Self, allocator: std.mem.Allocator, input: delete_image_pipeline.DeleteImagePipelineInput, options: CallOptions) !delete_image_pipeline.DeleteImagePipelineOutput {
        return delete_image_pipeline.execute(self, allocator, input, options);
    }

    /// Deletes an image recipe.
    pub fn deleteImageRecipe(self: *Self, allocator: std.mem.Allocator, input: delete_image_recipe.DeleteImageRecipeInput, options: CallOptions) !delete_image_recipe.DeleteImageRecipeOutput {
        return delete_image_recipe.execute(self, allocator, input, options);
    }

    /// Deletes an infrastructure configuration. You can't delete a configuration
    /// that an image pipeline still references. The request fails with
    /// `ResourceDependencyException`. Update or delete the referencing
    /// pipelines first.
    pub fn deleteInfrastructureConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_infrastructure_configuration.DeleteInfrastructureConfigurationInput, options: CallOptions) !delete_infrastructure_configuration.DeleteInfrastructureConfigurationOutput {
        return delete_infrastructure_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the specified lifecycle policy resource. Deleting the policy removes
    /// its schedule, so no further lifecycle runs occur for that policy. If a
    /// lifecycle execution is in progress for the policy, Image Builder cancels it.
    /// Deletion
    /// doesn't revert actions that the policy already applied to your
    /// resources.
    pub fn deleteLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_lifecycle_policy.DeleteLifecyclePolicyInput, options: CallOptions) !delete_lifecycle_policy.DeleteLifecyclePolicyOutput {
        return delete_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Deletes a specific workflow resource. You can't delete a workflow build
    /// version while an image pipeline references it. The request fails with
    /// `ResourceDependencyException`.
    pub fn deleteWorkflow(self: *Self, allocator: std.mem.Allocator, input: delete_workflow.DeleteWorkflowInput, options: CallOptions) !delete_workflow.DeleteWorkflowOutput {
        return delete_workflow.execute(self, allocator, input, options);
    }

    /// Distributes an existing AMI to target Regions and accounts without running
    /// the full image build process. This operation only runs the distribution
    /// phase on an image that has already been built.
    pub fn distributeImage(self: *Self, allocator: std.mem.Allocator, input: distribute_image.DistributeImageInput, options: CallOptions) !distribute_image.DistributeImageOutput {
        return distribute_image.execute(self, allocator, input, options);
    }

    /// Retrieves a component object.
    pub fn getComponent(self: *Self, allocator: std.mem.Allocator, input: get_component.GetComponentInput, options: CallOptions) !get_component.GetComponentOutput {
        return get_component.execute(self, allocator, input, options);
    }

    /// Retrieves a component policy.
    pub fn getComponentPolicy(self: *Self, allocator: std.mem.Allocator, input: get_component_policy.GetComponentPolicyInput, options: CallOptions) !get_component_policy.GetComponentPolicyOutput {
        return get_component_policy.execute(self, allocator, input, options);
    }

    /// Retrieves a container recipe.
    pub fn getContainerRecipe(self: *Self, allocator: std.mem.Allocator, input: get_container_recipe.GetContainerRecipeInput, options: CallOptions) !get_container_recipe.GetContainerRecipeOutput {
        return get_container_recipe.execute(self, allocator, input, options);
    }

    /// Retrieves the policy for a container recipe.
    pub fn getContainerRecipePolicy(self: *Self, allocator: std.mem.Allocator, input: get_container_recipe_policy.GetContainerRecipePolicyInput, options: CallOptions) !get_container_recipe_policy.GetContainerRecipePolicyOutput {
        return get_container_recipe_policy.execute(self, allocator, input, options);
    }

    /// Retrieves a distribution configuration.
    pub fn getDistributionConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_distribution_configuration.GetDistributionConfigurationInput, options: CallOptions) !get_distribution_configuration.GetDistributionConfigurationOutput {
        return get_distribution_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves an image.
    pub fn getImage(self: *Self, allocator: std.mem.Allocator, input: get_image.GetImageInput, options: CallOptions) !get_image.GetImageOutput {
        return get_image.execute(self, allocator, input, options);
    }

    /// Retrieves an image pipeline.
    pub fn getImagePipeline(self: *Self, allocator: std.mem.Allocator, input: get_image_pipeline.GetImagePipelineInput, options: CallOptions) !get_image_pipeline.GetImagePipelineOutput {
        return get_image_pipeline.execute(self, allocator, input, options);
    }

    /// Retrieves an image policy.
    pub fn getImagePolicy(self: *Self, allocator: std.mem.Allocator, input: get_image_policy.GetImagePolicyInput, options: CallOptions) !get_image_policy.GetImagePolicyOutput {
        return get_image_policy.execute(self, allocator, input, options);
    }

    /// Retrieves an image recipe.
    pub fn getImageRecipe(self: *Self, allocator: std.mem.Allocator, input: get_image_recipe.GetImageRecipeInput, options: CallOptions) !get_image_recipe.GetImageRecipeOutput {
        return get_image_recipe.execute(self, allocator, input, options);
    }

    /// Retrieves an image recipe policy.
    pub fn getImageRecipePolicy(self: *Self, allocator: std.mem.Allocator, input: get_image_recipe_policy.GetImageRecipePolicyInput, options: CallOptions) !get_image_recipe_policy.GetImageRecipePolicyOutput {
        return get_image_recipe_policy.execute(self, allocator, input, options);
    }

    /// Retrieves an infrastructure configuration.
    pub fn getInfrastructureConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_infrastructure_configuration.GetInfrastructureConfigurationInput, options: CallOptions) !get_infrastructure_configuration.GetInfrastructureConfigurationOutput {
        return get_infrastructure_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves runtime information for a lifecycle execution – a single run of
    /// lifecycle actions that a lifecycle policy or a
    /// StartResourceStateUpdate request started.
    pub fn getLifecycleExecution(self: *Self, allocator: std.mem.Allocator, input: get_lifecycle_execution.GetLifecycleExecutionInput, options: CallOptions) !get_lifecycle_execution.GetLifecycleExecutionOutput {
        return get_lifecycle_execution.execute(self, allocator, input, options);
    }

    /// Retrieves details for the specified image lifecycle policy.
    pub fn getLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: get_lifecycle_policy.GetLifecyclePolicyInput, options: CallOptions) !get_lifecycle_policy.GetLifecyclePolicyOutput {
        return get_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Verifies the subscription and performs resource dependency checks on the
    /// requested Amazon Web Services Marketplace resource. The caller must be
    /// entitled to the resource. For
    /// Amazon Web Services Marketplace components, the response contains fields to
    /// download the components
    /// and their artifacts.
    pub fn getMarketplaceResource(self: *Self, allocator: std.mem.Allocator, input: get_marketplace_resource.GetMarketplaceResourceInput, options: CallOptions) !get_marketplace_resource.GetMarketplaceResourceOutput {
        return get_marketplace_resource.execute(self, allocator, input, options);
    }

    /// Retrieves a workflow resource object.
    pub fn getWorkflow(self: *Self, allocator: std.mem.Allocator, input: get_workflow.GetWorkflowInput, options: CallOptions) !get_workflow.GetWorkflowOutput {
        return get_workflow.execute(self, allocator, input, options);
    }

    /// Retrieves runtime information for a specific runtime instance
    /// of the workflow.
    pub fn getWorkflowExecution(self: *Self, allocator: std.mem.Allocator, input: get_workflow_execution.GetWorkflowExecutionInput, options: CallOptions) !get_workflow_execution.GetWorkflowExecutionOutput {
        return get_workflow_execution.execute(self, allocator, input, options);
    }

    /// Retrieves runtime information for a specific runtime instance of
    /// the workflow step.
    pub fn getWorkflowStepExecution(self: *Self, allocator: std.mem.Allocator, input: get_workflow_step_execution.GetWorkflowStepExecutionInput, options: CallOptions) !get_workflow_step_execution.GetWorkflowStepExecutionOutput {
        return get_workflow_step_execution.execute(self, allocator, input, options);
    }

    /// Imports a component and transforms its data into a component document. For
    /// the `SHELL` format, Image Builder wraps your script in a component
    /// document with a single step that runs the script.
    pub fn importComponent(self: *Self, allocator: std.mem.Allocator, input: import_component.ImportComponentInput, options: CallOptions) !import_component.ImportComponentOutput {
        return import_component.execute(self, allocator, input, options);
    }

    /// Imports a Windows operating system image from a verified Microsoft ISO disk
    /// file. The following disk images are supported:
    ///
    /// * Windows 11 Enterprise
    ///
    /// The response returns as soon as Image Builder creates the new image resource
    /// in the
    /// `PENDING` state. The conversion from ISO file to AMI then runs
    /// asynchronously on an EC2 instance that Image Builder launches with the
    /// specified
    /// infrastructure configuration.
    pub fn importDiskImage(self: *Self, allocator: std.mem.Allocator, input: import_disk_image.ImportDiskImageInput, options: CallOptions) !import_disk_image.ImportDiskImageOutput {
        return import_disk_image.execute(self, allocator, input, options);
    }

    /// Creates an Image Builder image resource from an Amazon EC2 VM import task.
    /// The response
    /// returns as soon as Image Builder creates the image resource in the
    /// `PENDING` state. Image Builder then monitors the import task
    /// asynchronously. When the task completes, Image Builder records the AMI that
    /// it
    /// produced as the new image's output resource and marks the image
    /// `AVAILABLE`. You can then use the imported image as the base
    /// image for your recipes.
    ///
    /// To create the VM import task, use the Amazon EC2 API
    /// [ImportImage](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportImage.html)
    /// operation, or the
    /// [import-image](https://docs.aws.amazon.com/cli/latest/reference/ec2/import-image.html)
    /// CLI command.
    pub fn importVmImage(self: *Self, allocator: std.mem.Allocator, input: import_vm_image.ImportVmImageInput, options: CallOptions) !import_vm_image.ImportVmImageOutput {
        return import_vm_image.execute(self, allocator, input, options);
    }

    /// Returns a list of component build versions for the specified component
    /// version ARN. You can only list build versions for components that your
    /// account owns. Deprecated build versions aren't included in the
    /// results.
    pub fn listComponentBuildVersions(self: *Self, allocator: std.mem.Allocator, input: list_component_build_versions.ListComponentBuildVersionsInput, options: CallOptions) !list_component_build_versions.ListComponentBuildVersionsOutput {
        return list_component_build_versions.execute(self, allocator, input, options);
    }

    /// Returns the list of components that you have access to. By default, the
    /// response doesn't include components in the
    /// `DEPRECATED` state. To list deprecated components, use the
    /// `status` filter with the value `DEPRECATED`.
    ///
    /// The semantic version has four nodes: ../.
    /// You can assign values for the first three, and can filter on all of them.
    ///
    /// **Filtering:** You can use wildcards (x) to specify the most recent versions
    /// or nodes when
    /// selecting the base image or components for your recipe. When you use a
    /// wildcard in any node, all nodes
    /// to the right of the first wildcard must also be wildcards.
    pub fn listComponents(self: *Self, allocator: std.mem.Allocator, input: list_components.ListComponentsInput, options: CallOptions) !list_components.ListComponentsOutput {
        return list_components.execute(self, allocator, input, options);
    }

    /// Returns a list of container recipes.
    pub fn listContainerRecipes(self: *Self, allocator: std.mem.Allocator, input: list_container_recipes.ListContainerRecipesInput, options: CallOptions) !list_container_recipes.ListContainerRecipesOutput {
        return list_container_recipes.execute(self, allocator, input, options);
    }

    /// Returns a list of distribution configurations.
    pub fn listDistributionConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_distribution_configurations.ListDistributionConfigurationsInput, options: CallOptions) !list_distribution_configurations.ListDistributionConfigurationsOutput {
        return list_distribution_configurations.execute(self, allocator, input, options);
    }

    /// Returns a list of image build versions.
    pub fn listImageBuildVersions(self: *Self, allocator: std.mem.Allocator, input: list_image_build_versions.ListImageBuildVersionsInput, options: CallOptions) !list_image_build_versions.ListImageBuildVersionsOutput {
        return list_image_build_versions.execute(self, allocator, input, options);
    }

    /// Lists the packages that are associated with an image build version, as
    /// determined by
    /// Amazon Web Services Systems Manager Inventory at build time.
    pub fn listImagePackages(self: *Self, allocator: std.mem.Allocator, input: list_image_packages.ListImagePackagesInput, options: CallOptions) !list_image_packages.ListImagePackagesOutput {
        return list_image_packages.execute(self, allocator, input, options);
    }

    /// Returns a list of images created by the specified pipeline.
    pub fn listImagePipelineImages(self: *Self, allocator: std.mem.Allocator, input: list_image_pipeline_images.ListImagePipelineImagesInput, options: CallOptions) !list_image_pipeline_images.ListImagePipelineImagesOutput {
        return list_image_pipeline_images.execute(self, allocator, input, options);
    }

    /// Returns a list of image pipelines.
    pub fn listImagePipelines(self: *Self, allocator: std.mem.Allocator, input: list_image_pipelines.ListImagePipelinesInput, options: CallOptions) !list_image_pipelines.ListImagePipelinesOutput {
        return list_image_pipelines.execute(self, allocator, input, options);
    }

    /// Returns a list of image recipes.
    pub fn listImageRecipes(self: *Self, allocator: std.mem.Allocator, input: list_image_recipes.ListImageRecipesInput, options: CallOptions) !list_image_recipes.ListImageRecipesOutput {
        return list_image_recipes.execute(self, allocator, input, options);
    }

    /// Returns a list of image scan aggregations for your account. You can filter
    /// by the type
    /// of key that Image Builder uses to group results. For example, if you want to
    /// get a list of
    /// findings by severity level for one of your pipelines, you might specify your
    /// pipeline
    /// with the `imagePipelineArn` filter. If you don't specify a filter, Image
    /// Builder
    /// returns an aggregation for your account.
    ///
    /// To streamline results, you can use the following filters in your request:
    ///
    /// * `imageBuildVersionArn`
    ///
    /// * `imagePipelineArn`
    ///
    /// * `vulnerabilityId`
    pub fn listImageScanFindingAggregations(self: *Self, allocator: std.mem.Allocator, input: list_image_scan_finding_aggregations.ListImageScanFindingAggregationsInput, options: CallOptions) !list_image_scan_finding_aggregations.ListImageScanFindingAggregationsOutput {
        return list_image_scan_finding_aggregations.execute(self, allocator, input, options);
    }

    /// Returns a list of image scan findings for your account. Amazon Inspector
    /// generates the
    /// findings when it scans images that have scanning enabled.
    pub fn listImageScanFindings(self: *Self, allocator: std.mem.Allocator, input: list_image_scan_findings.ListImageScanFindingsInput, options: CallOptions) !list_image_scan_findings.ListImageScanFindingsOutput {
        return list_image_scan_findings.execute(self, allocator, input, options);
    }

    /// Returns the list of images that you have access to.
    pub fn listImages(self: *Self, allocator: std.mem.Allocator, input: list_images.ListImagesInput, options: CallOptions) !list_images.ListImagesOutput {
        return list_images.execute(self, allocator, input, options);
    }

    /// Returns a list of infrastructure configurations.
    pub fn listInfrastructureConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_infrastructure_configurations.ListInfrastructureConfigurationsInput, options: CallOptions) !list_infrastructure_configurations.ListInfrastructureConfigurationsOutput {
        return list_infrastructure_configurations.execute(self, allocator, input, options);
    }

    /// Lists resources that the runtime instance of the image lifecycle identified
    /// for lifecycle actions.
    pub fn listLifecycleExecutionResources(self: *Self, allocator: std.mem.Allocator, input: list_lifecycle_execution_resources.ListLifecycleExecutionResourcesInput, options: CallOptions) !list_lifecycle_execution_resources.ListLifecycleExecutionResourcesOutput {
        return list_lifecycle_execution_resources.execute(self, allocator, input, options);
    }

    /// Retrieves the lifecycle runtime history for the specified resource.
    pub fn listLifecycleExecutions(self: *Self, allocator: std.mem.Allocator, input: list_lifecycle_executions.ListLifecycleExecutionsInput, options: CallOptions) !list_lifecycle_executions.ListLifecycleExecutionsOutput {
        return list_lifecycle_executions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of lifecycle policies in your Amazon Web Services account.
    pub fn listLifecyclePolicies(self: *Self, allocator: std.mem.Allocator, input: list_lifecycle_policies.ListLifecyclePoliciesInput, options: CallOptions) !list_lifecycle_policies.ListLifecyclePoliciesOutput {
        return list_lifecycle_policies.execute(self, allocator, input, options);
    }

    /// Returns the list of tags for the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the workflow steps in your Amazon Web Services account that have
    /// paused at a
    /// `WaitForAction` step, and are waiting for you to respond. To send
    /// a response, call SendWorkflowStepAction.
    pub fn listWaitingWorkflowSteps(self: *Self, allocator: std.mem.Allocator, input: list_waiting_workflow_steps.ListWaitingWorkflowStepsInput, options: CallOptions) !list_waiting_workflow_steps.ListWaitingWorkflowStepsOutput {
        return list_waiting_workflow_steps.execute(self, allocator, input, options);
    }

    /// Returns a list of build versions for a specific workflow resource.
    pub fn listWorkflowBuildVersions(self: *Self, allocator: std.mem.Allocator, input: list_workflow_build_versions.ListWorkflowBuildVersionsInput, options: CallOptions) !list_workflow_build_versions.ListWorkflowBuildVersionsOutput {
        return list_workflow_build_versions.execute(self, allocator, input, options);
    }

    /// Returns a list of workflow runtime instance metadata objects for a specific
    /// image build
    /// version.
    pub fn listWorkflowExecutions(self: *Self, allocator: std.mem.Allocator, input: list_workflow_executions.ListWorkflowExecutionsInput, options: CallOptions) !list_workflow_executions.ListWorkflowExecutionsOutput {
        return list_workflow_executions.execute(self, allocator, input, options);
    }

    /// Returns runtime data for each step in a runtime instance of the workflow
    /// that you specify in the request.
    pub fn listWorkflowStepExecutions(self: *Self, allocator: std.mem.Allocator, input: list_workflow_step_executions.ListWorkflowStepExecutionsInput, options: CallOptions) !list_workflow_step_executions.ListWorkflowStepExecutionsOutput {
        return list_workflow_step_executions.execute(self, allocator, input, options);
    }

    /// Lists workflow versions based on filtering parameters. To list the build
    /// versions of a specific workflow version, call
    /// ListWorkflowBuildVersions.
    pub fn listWorkflows(self: *Self, allocator: std.mem.Allocator, input: list_workflows.ListWorkflowsInput, options: CallOptions) !list_workflows.ListWorkflowsOutput {
        return list_workflows.execute(self, allocator, input, options);
    }

    /// Applies a policy to a component. The preferred way to share resources is
    /// with
    /// the RAM API
    /// [CreateResourceShare](https://docs.aws.amazon.com/ram/latest/APIReference/API_CreateResourceShare.html). If you use the PutComponentPolicy operation instead, you
    /// must also call the RAM API
    /// [PromoteResourceShareCreatedFromPolicy](https://docs.aws.amazon.com/ram/latest/APIReference/API_PromoteResourceShareCreatedFromPolicy.html). Otherwise, the resource
    /// isn't visible to the principals that it's shared with.
    pub fn putComponentPolicy(self: *Self, allocator: std.mem.Allocator, input: put_component_policy.PutComponentPolicyInput, options: CallOptions) !put_component_policy.PutComponentPolicyOutput {
        return put_component_policy.execute(self, allocator, input, options);
    }

    /// Applies a policy to a container recipe. The preferred way to share resources
    /// is with
    /// the RAM API
    /// [CreateResourceShare](https://docs.aws.amazon.com/ram/latest/APIReference/API_CreateResourceShare.html). If you use the PutContainerRecipePolicy operation instead, you
    /// must also call the RAM API
    /// [PromoteResourceShareCreatedFromPolicy](https://docs.aws.amazon.com/ram/latest/APIReference/API_PromoteResourceShareCreatedFromPolicy.html). Otherwise, the resource
    /// isn't visible to the principals that it's shared with.
    pub fn putContainerRecipePolicy(self: *Self, allocator: std.mem.Allocator, input: put_container_recipe_policy.PutContainerRecipePolicyInput, options: CallOptions) !put_container_recipe_policy.PutContainerRecipePolicyOutput {
        return put_container_recipe_policy.execute(self, allocator, input, options);
    }

    /// Applies a policy to an image. The preferred way to share resources is with
    /// the RAM API
    /// [CreateResourceShare](https://docs.aws.amazon.com/ram/latest/APIReference/API_CreateResourceShare.html). If you use the PutImagePolicy operation instead, you
    /// must also call the RAM API
    /// [PromoteResourceShareCreatedFromPolicy](https://docs.aws.amazon.com/ram/latest/APIReference/API_PromoteResourceShareCreatedFromPolicy.html). Otherwise, the resource
    /// isn't visible to the principals that it's shared with.
    pub fn putImagePolicy(self: *Self, allocator: std.mem.Allocator, input: put_image_policy.PutImagePolicyInput, options: CallOptions) !put_image_policy.PutImagePolicyOutput {
        return put_image_policy.execute(self, allocator, input, options);
    }

    /// Applies a policy to an image recipe. The preferred way to share resources is
    /// with
    /// the RAM API
    /// [CreateResourceShare](https://docs.aws.amazon.com/ram/latest/APIReference/API_CreateResourceShare.html). If you use the PutImageRecipePolicy operation instead, you
    /// must also call the RAM API
    /// [PromoteResourceShareCreatedFromPolicy](https://docs.aws.amazon.com/ram/latest/APIReference/API_PromoteResourceShareCreatedFromPolicy.html). Otherwise, the resource
    /// isn't visible to the principals that it's shared with.
    pub fn putImageRecipePolicy(self: *Self, allocator: std.mem.Allocator, input: put_image_recipe_policy.PutImageRecipePolicyInput, options: CallOptions) !put_image_recipe_policy.PutImageRecipePolicyOutput {
        return put_image_recipe_policy.execute(self, allocator, input, options);
    }

    /// Retries a failed or canceled image build without rebuilding the phases
    /// that already completed. The image re-runs asynchronously in place: the same
    /// build version returns to the test or distribution phase where it failed and
    /// continues from there. No new image build version is created. Retry is only
    /// supported for AMI-based images.
    pub fn retryImage(self: *Self, allocator: std.mem.Allocator, input: retry_image.RetryImageInput, options: CallOptions) !retry_image.RetryImageOutput {
        return retry_image.execute(self, allocator, input, options);
    }

    /// Sends an action to a workflow step that has paused at a
    /// `WaitForAction` step, so that image creation can continue.
    /// To find the steps that are waiting for an action, call
    /// ListWaitingWorkflowSteps.
    pub fn sendWorkflowStepAction(self: *Self, allocator: std.mem.Allocator, input: send_workflow_step_action.SendWorkflowStepActionInput, options: CallOptions) !send_workflow_step_action.SendWorkflowStepActionOutput {
        return send_workflow_step_action.execute(self, allocator, input, options);
    }

    /// Manually triggers a pipeline to create an image. You can start a build
    /// this way whether the pipeline is enabled or disabled. The response returns
    /// as soon as Image Builder creates the new image resource and queues the
    /// build. Use
    /// the returned `imageBuildVersionArn` with
    /// GetImage to track build progress.
    pub fn startImagePipelineExecution(self: *Self, allocator: std.mem.Allocator, input: start_image_pipeline_execution.StartImagePipelineExecutionInput, options: CallOptions) !start_image_pipeline_execution.StartImagePipelineExecutionOutput {
        return start_image_pipeline_execution.execute(self, allocator, input, options);
    }

    /// Begins an ad-hoc state change for the specified image build version.
    /// This is a one-time operation - if you schedule the update, it runs only
    /// once. If the
    /// request includes underlying resources, or schedules the update far enough in
    /// the future, Image Builder runs the update as an asynchronous lifecycle
    /// execution and
    /// returns its identifier. Otherwise, for target states other than
    /// `DELETED`, the state change applies immediately. If a request
    /// that starts a lifecycle execution arrives while the image already has one in
    /// progress, Image Builder rejects it.
    pub fn startResourceStateUpdate(self: *Self, allocator: std.mem.Allocator, input: start_resource_state_update.StartResourceStateUpdateInput, options: CallOptions) !start_resource_state_update.StartResourceStateUpdateOutput {
        return start_resource_state_update.execute(self, allocator, input, options);
    }

    /// Adds a tag to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a distribution configuration. Distribution configurations define and
    /// configure the outputs for your images, including the target Regions,
    /// accounts, and settings for each Region.
    ///
    /// This operation doesn't support selective updates. The request
    /// replaces the stored configuration, so include every setting that you
    /// want to keep.
    pub fn updateDistributionConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_distribution_configuration.UpdateDistributionConfigurationInput, options: CallOptions) !update_distribution_configuration.UpdateDistributionConfigurationOutput {
        return update_distribution_configuration.execute(self, allocator, input, options);
    }

    /// Updates an image pipeline. Use image pipelines to automate the creation and
    /// distribution of images. You must specify exactly one recipe for your image,
    /// using either
    /// a `containerRecipeArn` or an `imageRecipeArn`. The
    /// recipe must be the same type, image or container, as the pipeline's current
    /// recipe.
    ///
    /// UpdateImagePipeline does not support selective updates. The request
    /// replaces the pipeline's entire configuration, so include every setting
    /// that you want to keep. Any optional property that you omit is removed
    /// or reset to its default.
    pub fn updateImagePipeline(self: *Self, allocator: std.mem.Allocator, input: update_image_pipeline.UpdateImagePipelineInput, options: CallOptions) !update_image_pipeline.UpdateImagePipelineOutput {
        return update_image_pipeline.execute(self, allocator, input, options);
    }

    /// Updates an infrastructure configuration. An infrastructure configuration
    /// defines
    /// the environment in which Image Builder builds and tests your image.
    ///
    /// This operation doesn't support selective updates.
    /// The request replaces the configuration, so include every setting that
    /// you want to keep. Omitted optional properties are cleared.
    pub fn updateInfrastructureConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_infrastructure_configuration.UpdateInfrastructureConfigurationInput, options: CallOptions) !update_infrastructure_configuration.UpdateInfrastructureConfigurationOutput {
        return update_infrastructure_configuration.execute(self, allocator, input, options);
    }

    /// Updates the specified lifecycle policy. The request replaces the existing
    /// policy configuration rather than merging changes, so re-specify every
    /// setting
    /// that you want to keep. The `resourceType` must match the existing
    /// policy's value.
    pub fn updateLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: update_lifecycle_policy.UpdateLifecyclePolicyInput, options: CallOptions) !update_lifecycle_policy.UpdateLifecyclePolicyOutput {
        return update_lifecycle_policy.execute(self, allocator, input, options);
    }

    pub fn listComponentBuildVersionsPaginator(self: *Self, params: list_component_build_versions.ListComponentBuildVersionsInput) paginator.ListComponentBuildVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listComponentsPaginator(self: *Self, params: list_components.ListComponentsInput) paginator.ListComponentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listContainerRecipesPaginator(self: *Self, params: list_container_recipes.ListContainerRecipesInput) paginator.ListContainerRecipesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDistributionConfigurationsPaginator(self: *Self, params: list_distribution_configurations.ListDistributionConfigurationsInput) paginator.ListDistributionConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listImageBuildVersionsPaginator(self: *Self, params: list_image_build_versions.ListImageBuildVersionsInput) paginator.ListImageBuildVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listImagePackagesPaginator(self: *Self, params: list_image_packages.ListImagePackagesInput) paginator.ListImagePackagesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listImagePipelineImagesPaginator(self: *Self, params: list_image_pipeline_images.ListImagePipelineImagesInput) paginator.ListImagePipelineImagesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listImagePipelinesPaginator(self: *Self, params: list_image_pipelines.ListImagePipelinesInput) paginator.ListImagePipelinesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listImageRecipesPaginator(self: *Self, params: list_image_recipes.ListImageRecipesInput) paginator.ListImageRecipesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listImageScanFindingAggregationsPaginator(self: *Self, params: list_image_scan_finding_aggregations.ListImageScanFindingAggregationsInput) paginator.ListImageScanFindingAggregationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listImageScanFindingsPaginator(self: *Self, params: list_image_scan_findings.ListImageScanFindingsInput) paginator.ListImageScanFindingsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listImagesPaginator(self: *Self, params: list_images.ListImagesInput) paginator.ListImagesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listInfrastructureConfigurationsPaginator(self: *Self, params: list_infrastructure_configurations.ListInfrastructureConfigurationsInput) paginator.ListInfrastructureConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listLifecycleExecutionResourcesPaginator(self: *Self, params: list_lifecycle_execution_resources.ListLifecycleExecutionResourcesInput) paginator.ListLifecycleExecutionResourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listLifecycleExecutionsPaginator(self: *Self, params: list_lifecycle_executions.ListLifecycleExecutionsInput) paginator.ListLifecycleExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listLifecyclePoliciesPaginator(self: *Self, params: list_lifecycle_policies.ListLifecyclePoliciesInput) paginator.ListLifecyclePoliciesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWaitingWorkflowStepsPaginator(self: *Self, params: list_waiting_workflow_steps.ListWaitingWorkflowStepsInput) paginator.ListWaitingWorkflowStepsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWorkflowBuildVersionsPaginator(self: *Self, params: list_workflow_build_versions.ListWorkflowBuildVersionsInput) paginator.ListWorkflowBuildVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWorkflowExecutionsPaginator(self: *Self, params: list_workflow_executions.ListWorkflowExecutionsInput) paginator.ListWorkflowExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWorkflowStepExecutionsPaginator(self: *Self, params: list_workflow_step_executions.ListWorkflowStepExecutionsInput) paginator.ListWorkflowStepExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWorkflowsPaginator(self: *Self, params: list_workflows.ListWorkflowsInput) paginator.ListWorkflowsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
