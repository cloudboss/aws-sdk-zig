const aws = @import("aws");
const std = @import("std");

const add_association = @import("add_association.zig");
const add_tags = @import("add_tags.zig");
const associate_trial_component = @import("associate_trial_component.zig");
const attach_cluster_node_volume = @import("attach_cluster_node_volume.zig");
const batch_add_cluster_nodes = @import("batch_add_cluster_nodes.zig");
const batch_delete_cluster_nodes = @import("batch_delete_cluster_nodes.zig");
const batch_describe_model_package = @import("batch_describe_model_package.zig");
const batch_reboot_cluster_nodes = @import("batch_reboot_cluster_nodes.zig");
const batch_replace_cluster_nodes = @import("batch_replace_cluster_nodes.zig");
const create_action = @import("create_action.zig");
const create_algorithm = @import("create_algorithm.zig");
const create_app = @import("create_app.zig");
const create_app_image_config = @import("create_app_image_config.zig");
const create_artifact = @import("create_artifact.zig");
const create_auto_ml_job = @import("create_auto_ml_job.zig");
const create_auto_ml_job_v2 = @import("create_auto_ml_job_v2.zig");
const create_cluster = @import("create_cluster.zig");
const create_cluster_scheduler_config = @import("create_cluster_scheduler_config.zig");
const create_code_repository = @import("create_code_repository.zig");
const create_compilation_job = @import("create_compilation_job.zig");
const create_compute_quota = @import("create_compute_quota.zig");
const create_context = @import("create_context.zig");
const create_data_quality_job_definition = @import("create_data_quality_job_definition.zig");
const create_device_fleet = @import("create_device_fleet.zig");
const create_domain = @import("create_domain.zig");
const create_edge_deployment_plan = @import("create_edge_deployment_plan.zig");
const create_edge_deployment_stage = @import("create_edge_deployment_stage.zig");
const create_edge_packaging_job = @import("create_edge_packaging_job.zig");
const create_endpoint = @import("create_endpoint.zig");
const create_endpoint_config = @import("create_endpoint_config.zig");
const create_experiment = @import("create_experiment.zig");
const create_feature_group = @import("create_feature_group.zig");
const create_flow_definition = @import("create_flow_definition.zig");
const create_hub = @import("create_hub.zig");
const create_hub_content_presigned_urls = @import("create_hub_content_presigned_urls.zig");
const create_hub_content_reference = @import("create_hub_content_reference.zig");
const create_human_task_ui = @import("create_human_task_ui.zig");
const create_hyper_parameter_tuning_job = @import("create_hyper_parameter_tuning_job.zig");
const create_image = @import("create_image.zig");
const create_image_version = @import("create_image_version.zig");
const create_inference_component = @import("create_inference_component.zig");
const create_inference_experiment = @import("create_inference_experiment.zig");
const create_inference_recommendations_job = @import("create_inference_recommendations_job.zig");
const create_labeling_job = @import("create_labeling_job.zig");
const create_mlflow_app = @import("create_mlflow_app.zig");
const create_mlflow_tracking_server = @import("create_mlflow_tracking_server.zig");
const create_model = @import("create_model.zig");
const create_model_bias_job_definition = @import("create_model_bias_job_definition.zig");
const create_model_card = @import("create_model_card.zig");
const create_model_card_export_job = @import("create_model_card_export_job.zig");
const create_model_explainability_job_definition = @import("create_model_explainability_job_definition.zig");
const create_model_package = @import("create_model_package.zig");
const create_model_package_group = @import("create_model_package_group.zig");
const create_model_quality_job_definition = @import("create_model_quality_job_definition.zig");
const create_monitoring_schedule = @import("create_monitoring_schedule.zig");
const create_notebook_instance = @import("create_notebook_instance.zig");
const create_notebook_instance_lifecycle_config = @import("create_notebook_instance_lifecycle_config.zig");
const create_optimization_job = @import("create_optimization_job.zig");
const create_partner_app = @import("create_partner_app.zig");
const create_partner_app_presigned_url = @import("create_partner_app_presigned_url.zig");
const create_pipeline = @import("create_pipeline.zig");
const create_presigned_domain_url = @import("create_presigned_domain_url.zig");
const create_presigned_mlflow_app_url = @import("create_presigned_mlflow_app_url.zig");
const create_presigned_mlflow_tracking_server_url = @import("create_presigned_mlflow_tracking_server_url.zig");
const create_presigned_notebook_instance_url = @import("create_presigned_notebook_instance_url.zig");
const create_processing_job = @import("create_processing_job.zig");
const create_project = @import("create_project.zig");
const create_space = @import("create_space.zig");
const create_studio_lifecycle_config = @import("create_studio_lifecycle_config.zig");
const create_training_job = @import("create_training_job.zig");
const create_training_plan = @import("create_training_plan.zig");
const create_transform_job = @import("create_transform_job.zig");
const create_trial = @import("create_trial.zig");
const create_trial_component = @import("create_trial_component.zig");
const create_user_profile = @import("create_user_profile.zig");
const create_workforce = @import("create_workforce.zig");
const create_workteam = @import("create_workteam.zig");
const delete_action = @import("delete_action.zig");
const delete_algorithm = @import("delete_algorithm.zig");
const delete_app = @import("delete_app.zig");
const delete_app_image_config = @import("delete_app_image_config.zig");
const delete_artifact = @import("delete_artifact.zig");
const delete_association = @import("delete_association.zig");
const delete_cluster = @import("delete_cluster.zig");
const delete_cluster_scheduler_config = @import("delete_cluster_scheduler_config.zig");
const delete_code_repository = @import("delete_code_repository.zig");
const delete_compilation_job = @import("delete_compilation_job.zig");
const delete_compute_quota = @import("delete_compute_quota.zig");
const delete_context = @import("delete_context.zig");
const delete_data_quality_job_definition = @import("delete_data_quality_job_definition.zig");
const delete_device_fleet = @import("delete_device_fleet.zig");
const delete_domain = @import("delete_domain.zig");
const delete_edge_deployment_plan = @import("delete_edge_deployment_plan.zig");
const delete_edge_deployment_stage = @import("delete_edge_deployment_stage.zig");
const delete_endpoint = @import("delete_endpoint.zig");
const delete_endpoint_config = @import("delete_endpoint_config.zig");
const delete_experiment = @import("delete_experiment.zig");
const delete_feature_group = @import("delete_feature_group.zig");
const delete_flow_definition = @import("delete_flow_definition.zig");
const delete_hub = @import("delete_hub.zig");
const delete_hub_content = @import("delete_hub_content.zig");
const delete_hub_content_reference = @import("delete_hub_content_reference.zig");
const delete_human_task_ui = @import("delete_human_task_ui.zig");
const delete_hyper_parameter_tuning_job = @import("delete_hyper_parameter_tuning_job.zig");
const delete_image = @import("delete_image.zig");
const delete_image_version = @import("delete_image_version.zig");
const delete_inference_component = @import("delete_inference_component.zig");
const delete_inference_experiment = @import("delete_inference_experiment.zig");
const delete_mlflow_app = @import("delete_mlflow_app.zig");
const delete_mlflow_tracking_server = @import("delete_mlflow_tracking_server.zig");
const delete_model = @import("delete_model.zig");
const delete_model_bias_job_definition = @import("delete_model_bias_job_definition.zig");
const delete_model_card = @import("delete_model_card.zig");
const delete_model_explainability_job_definition = @import("delete_model_explainability_job_definition.zig");
const delete_model_package = @import("delete_model_package.zig");
const delete_model_package_group = @import("delete_model_package_group.zig");
const delete_model_package_group_policy = @import("delete_model_package_group_policy.zig");
const delete_model_quality_job_definition = @import("delete_model_quality_job_definition.zig");
const delete_monitoring_schedule = @import("delete_monitoring_schedule.zig");
const delete_notebook_instance = @import("delete_notebook_instance.zig");
const delete_notebook_instance_lifecycle_config = @import("delete_notebook_instance_lifecycle_config.zig");
const delete_optimization_job = @import("delete_optimization_job.zig");
const delete_partner_app = @import("delete_partner_app.zig");
const delete_pipeline = @import("delete_pipeline.zig");
const delete_processing_job = @import("delete_processing_job.zig");
const delete_project = @import("delete_project.zig");
const delete_space = @import("delete_space.zig");
const delete_studio_lifecycle_config = @import("delete_studio_lifecycle_config.zig");
const delete_tags = @import("delete_tags.zig");
const delete_training_job = @import("delete_training_job.zig");
const delete_trial = @import("delete_trial.zig");
const delete_trial_component = @import("delete_trial_component.zig");
const delete_user_profile = @import("delete_user_profile.zig");
const delete_workforce = @import("delete_workforce.zig");
const delete_workteam = @import("delete_workteam.zig");
const deregister_devices = @import("deregister_devices.zig");
const describe_action = @import("describe_action.zig");
const describe_algorithm = @import("describe_algorithm.zig");
const describe_app = @import("describe_app.zig");
const describe_app_image_config = @import("describe_app_image_config.zig");
const describe_artifact = @import("describe_artifact.zig");
const describe_auto_ml_job = @import("describe_auto_ml_job.zig");
const describe_auto_ml_job_v2 = @import("describe_auto_ml_job_v2.zig");
const describe_cluster = @import("describe_cluster.zig");
const describe_cluster_event = @import("describe_cluster_event.zig");
const describe_cluster_node = @import("describe_cluster_node.zig");
const describe_cluster_scheduler_config = @import("describe_cluster_scheduler_config.zig");
const describe_code_repository = @import("describe_code_repository.zig");
const describe_compilation_job = @import("describe_compilation_job.zig");
const describe_compute_quota = @import("describe_compute_quota.zig");
const describe_context = @import("describe_context.zig");
const describe_data_quality_job_definition = @import("describe_data_quality_job_definition.zig");
const describe_device = @import("describe_device.zig");
const describe_device_fleet = @import("describe_device_fleet.zig");
const describe_domain = @import("describe_domain.zig");
const describe_edge_deployment_plan = @import("describe_edge_deployment_plan.zig");
const describe_edge_packaging_job = @import("describe_edge_packaging_job.zig");
const describe_endpoint = @import("describe_endpoint.zig");
const describe_endpoint_config = @import("describe_endpoint_config.zig");
const describe_experiment = @import("describe_experiment.zig");
const describe_feature_group = @import("describe_feature_group.zig");
const describe_feature_metadata = @import("describe_feature_metadata.zig");
const describe_flow_definition = @import("describe_flow_definition.zig");
const describe_hub = @import("describe_hub.zig");
const describe_hub_content = @import("describe_hub_content.zig");
const describe_human_task_ui = @import("describe_human_task_ui.zig");
const describe_hyper_parameter_tuning_job = @import("describe_hyper_parameter_tuning_job.zig");
const describe_image = @import("describe_image.zig");
const describe_image_version = @import("describe_image_version.zig");
const describe_inference_component = @import("describe_inference_component.zig");
const describe_inference_experiment = @import("describe_inference_experiment.zig");
const describe_inference_recommendations_job = @import("describe_inference_recommendations_job.zig");
const describe_labeling_job = @import("describe_labeling_job.zig");
const describe_lineage_group = @import("describe_lineage_group.zig");
const describe_mlflow_app = @import("describe_mlflow_app.zig");
const describe_mlflow_tracking_server = @import("describe_mlflow_tracking_server.zig");
const describe_model = @import("describe_model.zig");
const describe_model_bias_job_definition = @import("describe_model_bias_job_definition.zig");
const describe_model_card = @import("describe_model_card.zig");
const describe_model_card_export_job = @import("describe_model_card_export_job.zig");
const describe_model_explainability_job_definition = @import("describe_model_explainability_job_definition.zig");
const describe_model_package = @import("describe_model_package.zig");
const describe_model_package_group = @import("describe_model_package_group.zig");
const describe_model_quality_job_definition = @import("describe_model_quality_job_definition.zig");
const describe_monitoring_schedule = @import("describe_monitoring_schedule.zig");
const describe_notebook_instance = @import("describe_notebook_instance.zig");
const describe_notebook_instance_lifecycle_config = @import("describe_notebook_instance_lifecycle_config.zig");
const describe_optimization_job = @import("describe_optimization_job.zig");
const describe_partner_app = @import("describe_partner_app.zig");
const describe_pipeline = @import("describe_pipeline.zig");
const describe_pipeline_definition_for_execution = @import("describe_pipeline_definition_for_execution.zig");
const describe_pipeline_execution = @import("describe_pipeline_execution.zig");
const describe_processing_job = @import("describe_processing_job.zig");
const describe_project = @import("describe_project.zig");
const describe_reserved_capacity = @import("describe_reserved_capacity.zig");
const describe_space = @import("describe_space.zig");
const describe_studio_lifecycle_config = @import("describe_studio_lifecycle_config.zig");
const describe_subscribed_workteam = @import("describe_subscribed_workteam.zig");
const describe_training_job = @import("describe_training_job.zig");
const describe_training_plan = @import("describe_training_plan.zig");
const describe_transform_job = @import("describe_transform_job.zig");
const describe_trial = @import("describe_trial.zig");
const describe_trial_component = @import("describe_trial_component.zig");
const describe_user_profile = @import("describe_user_profile.zig");
const describe_workforce = @import("describe_workforce.zig");
const describe_workteam = @import("describe_workteam.zig");
const detach_cluster_node_volume = @import("detach_cluster_node_volume.zig");
const disable_sagemaker_servicecatalog_portfolio = @import("disable_sagemaker_servicecatalog_portfolio.zig");
const disassociate_trial_component = @import("disassociate_trial_component.zig");
const enable_sagemaker_servicecatalog_portfolio = @import("enable_sagemaker_servicecatalog_portfolio.zig");
const get_device_fleet_report = @import("get_device_fleet_report.zig");
const get_lineage_group_policy = @import("get_lineage_group_policy.zig");
const get_model_package_group_policy = @import("get_model_package_group_policy.zig");
const get_sagemaker_servicecatalog_portfolio_status = @import("get_sagemaker_servicecatalog_portfolio_status.zig");
const get_scaling_configuration_recommendation = @import("get_scaling_configuration_recommendation.zig");
const get_search_suggestions = @import("get_search_suggestions.zig");
const import_hub_content = @import("import_hub_content.zig");
const list_actions = @import("list_actions.zig");
const list_algorithms = @import("list_algorithms.zig");
const list_aliases = @import("list_aliases.zig");
const list_app_image_configs = @import("list_app_image_configs.zig");
const list_apps = @import("list_apps.zig");
const list_artifacts = @import("list_artifacts.zig");
const list_associations = @import("list_associations.zig");
const list_auto_ml_jobs = @import("list_auto_ml_jobs.zig");
const list_candidates_for_auto_ml_job = @import("list_candidates_for_auto_ml_job.zig");
const list_cluster_events = @import("list_cluster_events.zig");
const list_cluster_nodes = @import("list_cluster_nodes.zig");
const list_cluster_scheduler_configs = @import("list_cluster_scheduler_configs.zig");
const list_clusters = @import("list_clusters.zig");
const list_code_repositories = @import("list_code_repositories.zig");
const list_compilation_jobs = @import("list_compilation_jobs.zig");
const list_compute_quotas = @import("list_compute_quotas.zig");
const list_contexts = @import("list_contexts.zig");
const list_data_quality_job_definitions = @import("list_data_quality_job_definitions.zig");
const list_device_fleets = @import("list_device_fleets.zig");
const list_devices = @import("list_devices.zig");
const list_domains = @import("list_domains.zig");
const list_edge_deployment_plans = @import("list_edge_deployment_plans.zig");
const list_edge_packaging_jobs = @import("list_edge_packaging_jobs.zig");
const list_endpoint_configs = @import("list_endpoint_configs.zig");
const list_endpoints = @import("list_endpoints.zig");
const list_experiments = @import("list_experiments.zig");
const list_feature_groups = @import("list_feature_groups.zig");
const list_flow_definitions = @import("list_flow_definitions.zig");
const list_hub_content_versions = @import("list_hub_content_versions.zig");
const list_hub_contents = @import("list_hub_contents.zig");
const list_hubs = @import("list_hubs.zig");
const list_human_task_uis = @import("list_human_task_uis.zig");
const list_hyper_parameter_tuning_jobs = @import("list_hyper_parameter_tuning_jobs.zig");
const list_image_versions = @import("list_image_versions.zig");
const list_images = @import("list_images.zig");
const list_inference_components = @import("list_inference_components.zig");
const list_inference_experiments = @import("list_inference_experiments.zig");
const list_inference_recommendations_job_steps = @import("list_inference_recommendations_job_steps.zig");
const list_inference_recommendations_jobs = @import("list_inference_recommendations_jobs.zig");
const list_labeling_jobs = @import("list_labeling_jobs.zig");
const list_labeling_jobs_for_workteam = @import("list_labeling_jobs_for_workteam.zig");
const list_lineage_groups = @import("list_lineage_groups.zig");
const list_mlflow_apps = @import("list_mlflow_apps.zig");
const list_mlflow_tracking_servers = @import("list_mlflow_tracking_servers.zig");
const list_model_bias_job_definitions = @import("list_model_bias_job_definitions.zig");
const list_model_card_export_jobs = @import("list_model_card_export_jobs.zig");
const list_model_card_versions = @import("list_model_card_versions.zig");
const list_model_cards = @import("list_model_cards.zig");
const list_model_explainability_job_definitions = @import("list_model_explainability_job_definitions.zig");
const list_model_metadata = @import("list_model_metadata.zig");
const list_model_package_groups = @import("list_model_package_groups.zig");
const list_model_packages = @import("list_model_packages.zig");
const list_model_quality_job_definitions = @import("list_model_quality_job_definitions.zig");
const list_models = @import("list_models.zig");
const list_monitoring_alert_history = @import("list_monitoring_alert_history.zig");
const list_monitoring_alerts = @import("list_monitoring_alerts.zig");
const list_monitoring_executions = @import("list_monitoring_executions.zig");
const list_monitoring_schedules = @import("list_monitoring_schedules.zig");
const list_notebook_instance_lifecycle_configs = @import("list_notebook_instance_lifecycle_configs.zig");
const list_notebook_instances = @import("list_notebook_instances.zig");
const list_optimization_jobs = @import("list_optimization_jobs.zig");
const list_partner_apps = @import("list_partner_apps.zig");
const list_pipeline_execution_steps = @import("list_pipeline_execution_steps.zig");
const list_pipeline_executions = @import("list_pipeline_executions.zig");
const list_pipeline_parameters_for_execution = @import("list_pipeline_parameters_for_execution.zig");
const list_pipeline_versions = @import("list_pipeline_versions.zig");
const list_pipelines = @import("list_pipelines.zig");
const list_processing_jobs = @import("list_processing_jobs.zig");
const list_projects = @import("list_projects.zig");
const list_resource_catalogs = @import("list_resource_catalogs.zig");
const list_spaces = @import("list_spaces.zig");
const list_stage_devices = @import("list_stage_devices.zig");
const list_studio_lifecycle_configs = @import("list_studio_lifecycle_configs.zig");
const list_subscribed_workteams = @import("list_subscribed_workteams.zig");
const list_tags = @import("list_tags.zig");
const list_training_jobs = @import("list_training_jobs.zig");
const list_training_jobs_for_hyper_parameter_tuning_job = @import("list_training_jobs_for_hyper_parameter_tuning_job.zig");
const list_training_plans = @import("list_training_plans.zig");
const list_transform_jobs = @import("list_transform_jobs.zig");
const list_trial_components = @import("list_trial_components.zig");
const list_trials = @import("list_trials.zig");
const list_ultra_servers_by_reserved_capacity = @import("list_ultra_servers_by_reserved_capacity.zig");
const list_user_profiles = @import("list_user_profiles.zig");
const list_workforces = @import("list_workforces.zig");
const list_workteams = @import("list_workteams.zig");
const put_model_package_group_policy = @import("put_model_package_group_policy.zig");
const query_lineage = @import("query_lineage.zig");
const register_devices = @import("register_devices.zig");
const render_ui_template = @import("render_ui_template.zig");
const retry_pipeline_execution = @import("retry_pipeline_execution.zig");
const search_ = @import("search.zig");
const search_training_plan_offerings = @import("search_training_plan_offerings.zig");
const send_pipeline_execution_step_failure = @import("send_pipeline_execution_step_failure.zig");
const send_pipeline_execution_step_success = @import("send_pipeline_execution_step_success.zig");
const start_edge_deployment_stage = @import("start_edge_deployment_stage.zig");
const start_inference_experiment = @import("start_inference_experiment.zig");
const start_mlflow_tracking_server = @import("start_mlflow_tracking_server.zig");
const start_monitoring_schedule = @import("start_monitoring_schedule.zig");
const start_notebook_instance = @import("start_notebook_instance.zig");
const start_pipeline_execution = @import("start_pipeline_execution.zig");
const start_session = @import("start_session.zig");
const stop_auto_ml_job = @import("stop_auto_ml_job.zig");
const stop_compilation_job = @import("stop_compilation_job.zig");
const stop_edge_deployment_stage = @import("stop_edge_deployment_stage.zig");
const stop_edge_packaging_job = @import("stop_edge_packaging_job.zig");
const stop_hyper_parameter_tuning_job = @import("stop_hyper_parameter_tuning_job.zig");
const stop_inference_experiment = @import("stop_inference_experiment.zig");
const stop_inference_recommendations_job = @import("stop_inference_recommendations_job.zig");
const stop_labeling_job = @import("stop_labeling_job.zig");
const stop_mlflow_tracking_server = @import("stop_mlflow_tracking_server.zig");
const stop_monitoring_schedule = @import("stop_monitoring_schedule.zig");
const stop_notebook_instance = @import("stop_notebook_instance.zig");
const stop_optimization_job = @import("stop_optimization_job.zig");
const stop_pipeline_execution = @import("stop_pipeline_execution.zig");
const stop_processing_job = @import("stop_processing_job.zig");
const stop_training_job = @import("stop_training_job.zig");
const stop_transform_job = @import("stop_transform_job.zig");
const update_action = @import("update_action.zig");
const update_app_image_config = @import("update_app_image_config.zig");
const update_artifact = @import("update_artifact.zig");
const update_cluster = @import("update_cluster.zig");
const update_cluster_scheduler_config = @import("update_cluster_scheduler_config.zig");
const update_cluster_software = @import("update_cluster_software.zig");
const update_code_repository = @import("update_code_repository.zig");
const update_compute_quota = @import("update_compute_quota.zig");
const update_context = @import("update_context.zig");
const update_device_fleet = @import("update_device_fleet.zig");
const update_devices = @import("update_devices.zig");
const update_domain = @import("update_domain.zig");
const update_endpoint = @import("update_endpoint.zig");
const update_endpoint_weights_and_capacities = @import("update_endpoint_weights_and_capacities.zig");
const update_experiment = @import("update_experiment.zig");
const update_feature_group = @import("update_feature_group.zig");
const update_feature_metadata = @import("update_feature_metadata.zig");
const update_hub = @import("update_hub.zig");
const update_hub_content = @import("update_hub_content.zig");
const update_hub_content_reference = @import("update_hub_content_reference.zig");
const update_image = @import("update_image.zig");
const update_image_version = @import("update_image_version.zig");
const update_inference_component = @import("update_inference_component.zig");
const update_inference_component_runtime_config = @import("update_inference_component_runtime_config.zig");
const update_inference_experiment = @import("update_inference_experiment.zig");
const update_mlflow_app = @import("update_mlflow_app.zig");
const update_mlflow_tracking_server = @import("update_mlflow_tracking_server.zig");
const update_model_card = @import("update_model_card.zig");
const update_model_package = @import("update_model_package.zig");
const update_monitoring_alert = @import("update_monitoring_alert.zig");
const update_monitoring_schedule = @import("update_monitoring_schedule.zig");
const update_notebook_instance = @import("update_notebook_instance.zig");
const update_notebook_instance_lifecycle_config = @import("update_notebook_instance_lifecycle_config.zig");
const update_partner_app = @import("update_partner_app.zig");
const update_pipeline = @import("update_pipeline.zig");
const update_pipeline_execution = @import("update_pipeline_execution.zig");
const update_pipeline_version = @import("update_pipeline_version.zig");
const update_project = @import("update_project.zig");
const update_space = @import("update_space.zig");
const update_training_job = @import("update_training_job.zig");
const update_trial = @import("update_trial.zig");
const update_trial_component = @import("update_trial_component.zig");
const update_user_profile = @import("update_user_profile.zig");
const update_workforce = @import("update_workforce.zig");
const update_workteam = @import("update_workteam.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SageMaker";

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

    /// Creates an *association* between the source and the destination. A source
    /// can be associated with multiple destinations, and a destination can be
    /// associated with multiple sources. An association is a lineage tracking
    /// entity. For more information, see [Amazon SageMaker ML Lineage
    /// Tracking](https://docs.aws.amazon.com/sagemaker/latest/dg/lineage-tracking.html).
    pub fn addAssociation(self: *Self, allocator: std.mem.Allocator, input: add_association.AddAssociationInput, options: add_association.Options) !add_association.AddAssociationOutput {
        return add_association.execute(self, allocator, input, options);
    }

    /// Adds or overwrites one or more tags for the specified SageMaker resource.
    /// You can add tags to notebook instances, training jobs, hyperparameter tuning
    /// jobs, batch transform jobs, models, labeling jobs, work teams, endpoint
    /// configurations, and endpoints.
    ///
    /// Each tag consists of a key and an optional value. Tag keys must be unique
    /// per resource. For more information about tags, see For more information, see
    /// [Amazon Web Services Tagging
    /// Strategies](https://aws.amazon.com/answers/account-management/aws-tagging-strategies/).
    ///
    /// Tags that you add to a hyperparameter tuning job by calling this API are
    /// also added to any training jobs that the hyperparameter tuning job launches
    /// after you call this API, but not to training jobs that the hyperparameter
    /// tuning job launched before you called this API. To make sure that the tags
    /// associated with a hyperparameter tuning job are also added to all training
    /// jobs that the hyperparameter tuning job launches, add the tags when you
    /// first create the tuning job by specifying them in the `Tags` parameter of
    /// [CreateHyperParameterTuningJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateHyperParameterTuningJob.html)
    ///
    /// Tags that you add to a SageMaker Domain or User Profile by calling this API
    /// are also added to any Apps that the Domain or User Profile launches after
    /// you call this API, but not to Apps that the Domain or User Profile launched
    /// before you called this API. To make sure that the tags associated with a
    /// Domain or User Profile are also added to all Apps that the Domain or User
    /// Profile launches, add the tags when you first create the Domain or User
    /// Profile by specifying them in the `Tags` parameter of
    /// [CreateDomain](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateDomain.html) or [CreateUserProfile](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateUserProfile.html).
    pub fn addTags(self: *Self, allocator: std.mem.Allocator, input: add_tags.AddTagsInput, options: add_tags.Options) !add_tags.AddTagsOutput {
        return add_tags.execute(self, allocator, input, options);
    }

    /// Associates a trial component with a trial. A trial component can be
    /// associated with multiple trials. To disassociate a trial component from a
    /// trial, call the
    /// [DisassociateTrialComponent](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DisassociateTrialComponent.html) API.
    pub fn associateTrialComponent(self: *Self, allocator: std.mem.Allocator, input: associate_trial_component.AssociateTrialComponentInput, options: associate_trial_component.Options) !associate_trial_component.AssociateTrialComponentOutput {
        return associate_trial_component.execute(self, allocator, input, options);
    }

    /// Attaches your Amazon Elastic Block Store (Amazon EBS) volume to a node in
    /// your EKS orchestrated HyperPod cluster.
    ///
    /// This API works with the Amazon Elastic Block Store (Amazon EBS) Container
    /// Storage Interface (CSI) driver to manage the lifecycle of persistent storage
    /// in your HyperPod EKS clusters.
    pub fn attachClusterNodeVolume(self: *Self, allocator: std.mem.Allocator, input: attach_cluster_node_volume.AttachClusterNodeVolumeInput, options: attach_cluster_node_volume.Options) !attach_cluster_node_volume.AttachClusterNodeVolumeOutput {
        return attach_cluster_node_volume.execute(self, allocator, input, options);
    }

    /// Adds nodes to a HyperPod cluster by incrementing the target count for one or
    /// more instance groups. This operation returns a unique `NodeLogicalId` for
    /// each node being added, which can be used to track the provisioning status of
    /// the node. This API provides a safer alternative to `UpdateCluster` for
    /// scaling operations by avoiding unintended configuration changes.
    ///
    /// This API is only supported for clusters using `Continuous` as the
    /// `NodeProvisioningMode`.
    pub fn batchAddClusterNodes(self: *Self, allocator: std.mem.Allocator, input: batch_add_cluster_nodes.BatchAddClusterNodesInput, options: batch_add_cluster_nodes.Options) !batch_add_cluster_nodes.BatchAddClusterNodesOutput {
        return batch_add_cluster_nodes.execute(self, allocator, input, options);
    }

    /// Deletes specific nodes within a SageMaker HyperPod cluster.
    /// `BatchDeleteClusterNodes` accepts a cluster name and a list of node IDs.
    ///
    /// * To safeguard your work, back up your data to Amazon S3 or an FSx for
    ///   Lustre file system before invoking the API on a worker node group. This
    ///   will help prevent any potential data loss from the instance root volume.
    ///   For more information about backup, see [Use the backup script provided by
    ///   SageMaker
    ///   HyperPod](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-hyperpod-operate-cli-command.html#sagemaker-hyperpod-operate-cli-command-update-cluster-software-backup).
    /// * If you want to invoke this API on an existing cluster, you'll first need
    ///   to patch the cluster by running the [UpdateClusterSoftware
    ///   API](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateClusterSoftware.html). For more information about patching a cluster, see [Update the SageMaker HyperPod platform software of a cluster](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-hyperpod-operate-cli-command.html#sagemaker-hyperpod-operate-cli-command-update-cluster-software).
    pub fn batchDeleteClusterNodes(self: *Self, allocator: std.mem.Allocator, input: batch_delete_cluster_nodes.BatchDeleteClusterNodesInput, options: batch_delete_cluster_nodes.Options) !batch_delete_cluster_nodes.BatchDeleteClusterNodesOutput {
        return batch_delete_cluster_nodes.execute(self, allocator, input, options);
    }

    /// This action batch describes a list of versioned model packages
    pub fn batchDescribeModelPackage(self: *Self, allocator: std.mem.Allocator, input: batch_describe_model_package.BatchDescribeModelPackageInput, options: batch_describe_model_package.Options) !batch_describe_model_package.BatchDescribeModelPackageOutput {
        return batch_describe_model_package.execute(self, allocator, input, options);
    }

    /// Reboots specific nodes within a SageMaker HyperPod cluster using a soft
    /// recovery mechanism. `BatchRebootClusterNodes` performs a graceful reboot of
    /// the specified nodes by calling the Amazon Elastic Compute Cloud
    /// `RebootInstances` API, which attempts to cleanly shut down the operating
    /// system before restarting the instance.
    ///
    /// This operation is useful for recovering from transient issues or applying
    /// certain configuration changes that require a restart.
    ///
    /// * Rebooting a node may cause temporary service interruption for workloads
    ///   running on that node. Ensure your workloads can handle node restarts or
    ///   use appropriate scheduling to minimize impact.
    /// * You can reboot up to 25 nodes in a single request.
    /// * For SageMaker HyperPod clusters using the Slurm workload manager, ensure
    ///   rebooting nodes will not disrupt critical cluster operations.
    pub fn batchRebootClusterNodes(self: *Self, allocator: std.mem.Allocator, input: batch_reboot_cluster_nodes.BatchRebootClusterNodesInput, options: batch_reboot_cluster_nodes.Options) !batch_reboot_cluster_nodes.BatchRebootClusterNodesOutput {
        return batch_reboot_cluster_nodes.execute(self, allocator, input, options);
    }

    /// Replaces specific nodes within a SageMaker HyperPod cluster with new
    /// hardware. `BatchReplaceClusterNodes` terminates the specified instances and
    /// provisions new replacement instances with the same configuration but fresh
    /// hardware. The Amazon Machine Image (AMI) and instance configuration remain
    /// the same.
    ///
    /// This operation is useful for recovering from hardware failures or persistent
    /// issues that cannot be resolved through a reboot.
    ///
    /// * **Data Loss Warning:** Replacing nodes destroys all instance volumes,
    ///   including both root and secondary volumes. All data stored on these
    ///   volumes will be permanently lost and cannot be recovered.
    /// * To safeguard your work, back up your data to Amazon S3 or an FSx for
    ///   Lustre file system before invoking the API on a worker node group. This
    ///   will help prevent any potential data loss from the instance root volume.
    ///   For more information about backup, see [Use the backup script provided by
    ///   SageMaker
    ///   HyperPod](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-hyperpod-operate-cli-command.html#sagemaker-hyperpod-operate-cli-command-update-cluster-software-backup).
    /// * If you want to invoke this API on an existing cluster, you'll first need
    ///   to patch the cluster by running the [UpdateClusterSoftware
    ///   API](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateClusterSoftware.html). For more information about patching a cluster, see [Update the SageMaker HyperPod platform software of a cluster](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-hyperpod-operate-cli-command.html#sagemaker-hyperpod-operate-cli-command-update-cluster-software).
    /// * You can replace up to 25 nodes in a single request.
    pub fn batchReplaceClusterNodes(self: *Self, allocator: std.mem.Allocator, input: batch_replace_cluster_nodes.BatchReplaceClusterNodesInput, options: batch_replace_cluster_nodes.Options) !batch_replace_cluster_nodes.BatchReplaceClusterNodesOutput {
        return batch_replace_cluster_nodes.execute(self, allocator, input, options);
    }

    /// Creates an *action*. An action is a lineage tracking entity that represents
    /// an action or activity. For example, a model deployment or an HPO job.
    /// Generally, an action involves at least one input or output artifact. For
    /// more information, see [Amazon SageMaker ML Lineage
    /// Tracking](https://docs.aws.amazon.com/sagemaker/latest/dg/lineage-tracking.html).
    pub fn createAction(self: *Self, allocator: std.mem.Allocator, input: create_action.CreateActionInput, options: create_action.Options) !create_action.CreateActionOutput {
        return create_action.execute(self, allocator, input, options);
    }

    /// Create a machine learning algorithm that you can use in SageMaker and list
    /// in the Amazon Web Services Marketplace.
    pub fn createAlgorithm(self: *Self, allocator: std.mem.Allocator, input: create_algorithm.CreateAlgorithmInput, options: create_algorithm.Options) !create_algorithm.CreateAlgorithmOutput {
        return create_algorithm.execute(self, allocator, input, options);
    }

    /// Creates a running app for the specified UserProfile. This operation is
    /// automatically invoked by Amazon SageMaker AI upon access to the associated
    /// Domain, and when new kernel configurations are selected by the user. A user
    /// may have multiple Apps active simultaneously.
    pub fn createApp(self: *Self, allocator: std.mem.Allocator, input: create_app.CreateAppInput, options: create_app.Options) !create_app.CreateAppOutput {
        return create_app.execute(self, allocator, input, options);
    }

    /// Creates a configuration for running a SageMaker AI image as a KernelGateway
    /// app. The configuration specifies the Amazon Elastic File System storage
    /// volume on the image, and a list of the kernels in the image.
    pub fn createAppImageConfig(self: *Self, allocator: std.mem.Allocator, input: create_app_image_config.CreateAppImageConfigInput, options: create_app_image_config.Options) !create_app_image_config.CreateAppImageConfigOutput {
        return create_app_image_config.execute(self, allocator, input, options);
    }

    /// Creates an *artifact*. An artifact is a lineage tracking entity that
    /// represents a URI addressable object or data. Some examples are the S3 URI of
    /// a dataset and the ECR registry path of an image. For more information, see
    /// [Amazon SageMaker ML Lineage
    /// Tracking](https://docs.aws.amazon.com/sagemaker/latest/dg/lineage-tracking.html).
    pub fn createArtifact(self: *Self, allocator: std.mem.Allocator, input: create_artifact.CreateArtifactInput, options: create_artifact.Options) !create_artifact.CreateArtifactOutput {
        return create_artifact.execute(self, allocator, input, options);
    }

    /// Creates an Autopilot job also referred to as Autopilot experiment or AutoML
    /// job.
    ///
    /// An AutoML job in SageMaker AI is a fully automated process that allows you
    /// to build machine learning models with minimal effort and machine learning
    /// expertise. When initiating an AutoML job, you provide your data and
    /// optionally specify parameters tailored to your use case. SageMaker AI then
    /// automates the entire model development lifecycle, including data
    /// preprocessing, model training, tuning, and evaluation. AutoML jobs are
    /// designed to simplify and accelerate the model building process by automating
    /// various tasks and exploring different combinations of machine learning
    /// algorithms, data preprocessing techniques, and hyperparameter values. The
    /// output of an AutoML job comprises one or more trained models ready for
    /// deployment and inference. Additionally, SageMaker AI AutoML jobs generate a
    /// candidate model leaderboard, allowing you to select the best-performing
    /// model for deployment.
    ///
    /// For more information about AutoML jobs, see
    /// [https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-automate-model-development.html](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-automate-model-development.html) in the SageMaker AI developer guide.
    ///
    /// We recommend using the new versions
    /// [CreateAutoMLJobV2](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateAutoMLJobV2.html) and [DescribeAutoMLJobV2](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeAutoMLJobV2.html), which offer backward compatibility.
    ///
    /// `CreateAutoMLJobV2` can manage tabular problem types identical to those of
    /// its previous version `CreateAutoMLJob`, as well as time-series forecasting,
    /// non-tabular problem types such as image or text classification, and text
    /// generation (LLMs fine-tuning).
    ///
    /// Find guidelines about how to migrate a `CreateAutoMLJob` to
    /// `CreateAutoMLJobV2` in [Migrate a CreateAutoMLJob to
    /// CreateAutoMLJobV2](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-automate-model-development-create-experiment.html#autopilot-create-experiment-api-migrate-v1-v2).
    ///
    /// You can find the best-performing model after you run an AutoML job by
    /// calling
    /// [DescribeAutoMLJobV2](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeAutoMLJobV2.html) (recommended) or [DescribeAutoMLJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeAutoMLJob.html).
    pub fn createAutoMlJob(self: *Self, allocator: std.mem.Allocator, input: create_auto_ml_job.CreateAutoMLJobInput, options: create_auto_ml_job.Options) !create_auto_ml_job.CreateAutoMLJobOutput {
        return create_auto_ml_job.execute(self, allocator, input, options);
    }

    /// Creates an Autopilot job also referred to as Autopilot experiment or AutoML
    /// job V2.
    ///
    /// An AutoML job in SageMaker AI is a fully automated process that allows you
    /// to build machine learning models with minimal effort and machine learning
    /// expertise. When initiating an AutoML job, you provide your data and
    /// optionally specify parameters tailored to your use case. SageMaker AI then
    /// automates the entire model development lifecycle, including data
    /// preprocessing, model training, tuning, and evaluation. AutoML jobs are
    /// designed to simplify and accelerate the model building process by automating
    /// various tasks and exploring different combinations of machine learning
    /// algorithms, data preprocessing techniques, and hyperparameter values. The
    /// output of an AutoML job comprises one or more trained models ready for
    /// deployment and inference. Additionally, SageMaker AI AutoML jobs generate a
    /// candidate model leaderboard, allowing you to select the best-performing
    /// model for deployment.
    ///
    /// For more information about AutoML jobs, see
    /// [https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-automate-model-development.html](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-automate-model-development.html) in the SageMaker AI developer guide.
    ///
    /// AutoML jobs V2 support various problem types such as regression, binary, and
    /// multiclass classification with tabular data, text and image classification,
    /// time-series forecasting, and fine-tuning of large language models (LLMs) for
    /// text generation.
    ///
    /// [CreateAutoMLJobV2](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateAutoMLJobV2.html) and [DescribeAutoMLJobV2](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeAutoMLJobV2.html) are new versions of [CreateAutoMLJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateAutoMLJob.html) and [DescribeAutoMLJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeAutoMLJob.html) which offer backward compatibility.
    ///
    /// `CreateAutoMLJobV2` can manage tabular problem types identical to those of
    /// its previous version `CreateAutoMLJob`, as well as time-series forecasting,
    /// non-tabular problem types such as image or text classification, and text
    /// generation (LLMs fine-tuning).
    ///
    /// Find guidelines about how to migrate a `CreateAutoMLJob` to
    /// `CreateAutoMLJobV2` in [Migrate a CreateAutoMLJob to
    /// CreateAutoMLJobV2](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-automate-model-development-create-experiment.html#autopilot-create-experiment-api-migrate-v1-v2).
    ///
    /// For the list of available problem types supported by `CreateAutoMLJobV2`,
    /// see
    /// [AutoMLProblemTypeConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AutoMLProblemTypeConfig.html).
    ///
    /// You can find the best-performing model after you run an AutoML job V2 by
    /// calling
    /// [DescribeAutoMLJobV2](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeAutoMLJobV2.html).
    pub fn createAutoMlJobV2(self: *Self, allocator: std.mem.Allocator, input: create_auto_ml_job_v2.CreateAutoMLJobV2Input, options: create_auto_ml_job_v2.Options) !create_auto_ml_job_v2.CreateAutoMLJobV2Output {
        return create_auto_ml_job_v2.execute(self, allocator, input, options);
    }

    /// Creates an Amazon SageMaker HyperPod cluster. SageMaker HyperPod is a
    /// capability of SageMaker for creating and managing persistent clusters for
    /// developing large machine learning models, such as large language models
    /// (LLMs) and diffusion models. To learn more, see [Amazon SageMaker
    /// HyperPod](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-hyperpod.html) in the *Amazon SageMaker Developer Guide*.
    pub fn createCluster(self: *Self, allocator: std.mem.Allocator, input: create_cluster.CreateClusterInput, options: create_cluster.Options) !create_cluster.CreateClusterOutput {
        return create_cluster.execute(self, allocator, input, options);
    }

    /// Create cluster policy configuration. This policy is used for task
    /// prioritization and fair-share allocation of idle compute. This helps
    /// prioritize critical workloads and distributes idle compute across entities.
    pub fn createClusterSchedulerConfig(self: *Self, allocator: std.mem.Allocator, input: create_cluster_scheduler_config.CreateClusterSchedulerConfigInput, options: create_cluster_scheduler_config.Options) !create_cluster_scheduler_config.CreateClusterSchedulerConfigOutput {
        return create_cluster_scheduler_config.execute(self, allocator, input, options);
    }

    /// Creates a Git repository as a resource in your SageMaker AI account. You can
    /// associate the repository with notebook instances so that you can use Git
    /// source control for the notebooks you create. The Git repository is a
    /// resource in your SageMaker AI account, so it can be associated with more
    /// than one notebook instance, and it persists independently from the lifecycle
    /// of any notebook instances it is associated with.
    ///
    /// The repository can be hosted either in [Amazon Web Services
    /// CodeCommit](https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html) or in any other Git repository.
    pub fn createCodeRepository(self: *Self, allocator: std.mem.Allocator, input: create_code_repository.CreateCodeRepositoryInput, options: create_code_repository.Options) !create_code_repository.CreateCodeRepositoryOutput {
        return create_code_repository.execute(self, allocator, input, options);
    }

    /// Starts a model compilation job. After the model has been compiled, Amazon
    /// SageMaker AI saves the resulting model artifacts to an Amazon Simple Storage
    /// Service (Amazon S3) bucket that you specify.
    ///
    /// If you choose to host your model using Amazon SageMaker AI hosting services,
    /// you can use the resulting model artifacts as part of the model. You can also
    /// use the artifacts with Amazon Web Services IoT Greengrass. In that case,
    /// deploy them as an ML resource.
    ///
    /// In the request body, you provide the following:
    ///
    /// * A name for the compilation job
    /// * Information about the input model artifacts
    /// * The output location for the compiled model and the device (target) that
    ///   the model runs on
    /// * The Amazon Resource Name (ARN) of the IAM role that Amazon SageMaker AI
    ///   assumes to perform the model compilation job.
    ///
    /// You can also provide a `Tag` to track the model compilation job's resource
    /// use and costs. The response body contains the `CompilationJobArn` for the
    /// compiled job.
    ///
    /// To stop a model compilation job, use
    /// [StopCompilationJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_StopCompilationJob.html). To get information about a particular model compilation job, use [DescribeCompilationJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeCompilationJob.html). To get information about multiple model compilation jobs, use [ListCompilationJobs](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ListCompilationJobs.html).
    pub fn createCompilationJob(self: *Self, allocator: std.mem.Allocator, input: create_compilation_job.CreateCompilationJobInput, options: create_compilation_job.Options) !create_compilation_job.CreateCompilationJobOutput {
        return create_compilation_job.execute(self, allocator, input, options);
    }

    /// Create compute allocation definition. This defines how compute is allocated,
    /// shared, and borrowed for specified entities. Specifically, how to lend and
    /// borrow idle compute and assign a fair-share weight to the specified
    /// entities.
    pub fn createComputeQuota(self: *Self, allocator: std.mem.Allocator, input: create_compute_quota.CreateComputeQuotaInput, options: create_compute_quota.Options) !create_compute_quota.CreateComputeQuotaOutput {
        return create_compute_quota.execute(self, allocator, input, options);
    }

    /// Creates a *context*. A context is a lineage tracking entity that represents
    /// a logical grouping of other tracking or experiment entities. Some examples
    /// are an endpoint and a model package. For more information, see [Amazon
    /// SageMaker ML Lineage
    /// Tracking](https://docs.aws.amazon.com/sagemaker/latest/dg/lineage-tracking.html).
    pub fn createContext(self: *Self, allocator: std.mem.Allocator, input: create_context.CreateContextInput, options: create_context.Options) !create_context.CreateContextOutput {
        return create_context.execute(self, allocator, input, options);
    }

    /// Creates a definition for a job that monitors data quality and drift. For
    /// information about model monitor, see [Amazon SageMaker AI Model
    /// Monitor](https://docs.aws.amazon.com/sagemaker/latest/dg/model-monitor.html).
    pub fn createDataQualityJobDefinition(self: *Self, allocator: std.mem.Allocator, input: create_data_quality_job_definition.CreateDataQualityJobDefinitionInput, options: create_data_quality_job_definition.Options) !create_data_quality_job_definition.CreateDataQualityJobDefinitionOutput {
        return create_data_quality_job_definition.execute(self, allocator, input, options);
    }

    /// Creates a device fleet.
    pub fn createDeviceFleet(self: *Self, allocator: std.mem.Allocator, input: create_device_fleet.CreateDeviceFleetInput, options: create_device_fleet.Options) !create_device_fleet.CreateDeviceFleetOutput {
        return create_device_fleet.execute(self, allocator, input, options);
    }

    /// Creates a `Domain`. A domain consists of an associated Amazon Elastic File
    /// System volume, a list of authorized users, and a variety of security,
    /// application, policy, and Amazon Virtual Private Cloud (VPC) configurations.
    /// Users within a domain can share notebook files and other artifacts with each
    /// other.
    ///
    /// **EFS storage**
    ///
    /// When a domain is created, an EFS volume is created for use by all of the
    /// users within the domain. Each user receives a private home directory within
    /// the EFS volume for notebooks, Git repositories, and data files.
    ///
    /// SageMaker AI uses the Amazon Web Services Key Management Service (Amazon Web
    /// Services KMS) to encrypt the EFS volume attached to the domain with an
    /// Amazon Web Services managed key by default. For more control, you can
    /// specify a customer managed key. For more information, see [Protect Data at
    /// Rest Using
    /// Encryption](https://docs.aws.amazon.com/sagemaker/latest/dg/encryption-at-rest.html).
    ///
    /// **VPC configuration**
    ///
    /// All traffic between the domain and the Amazon EFS volume is through the
    /// specified VPC and subnets. For other traffic, you can specify the
    /// `AppNetworkAccessType` parameter. `AppNetworkAccessType` corresponds to the
    /// network access type that you choose when you onboard to the domain. The
    /// following options are available:
    ///
    /// * `PublicInternetOnly` - Non-EFS traffic goes through a VPC managed by
    ///   Amazon SageMaker AI, which allows internet access. This is the default
    ///   value.
    /// * `VpcOnly` - All traffic is through the specified VPC and subnets. Internet
    ///   access is disabled by default. To allow internet access, you must specify
    ///   a NAT gateway.
    ///
    /// When internet access is disabled, you won't be able to run a Amazon
    /// SageMaker AI Studio notebook or to train or host models unless your VPC has
    /// an interface endpoint to the SageMaker AI API and runtime or a NAT gateway
    /// and your security groups allow outbound connections.
    ///
    /// NFS traffic over TCP on port 2049 needs to be allowed in both inbound and
    /// outbound rules in order to launch a Amazon SageMaker AI Studio app
    /// successfully.
    ///
    /// For more information, see [Connect Amazon SageMaker AI Studio Notebooks to
    /// Resources in a
    /// VPC](https://docs.aws.amazon.com/sagemaker/latest/dg/studio-notebooks-and-internet-access.html).
    pub fn createDomain(self: *Self, allocator: std.mem.Allocator, input: create_domain.CreateDomainInput, options: create_domain.Options) !create_domain.CreateDomainOutput {
        return create_domain.execute(self, allocator, input, options);
    }

    /// Creates an edge deployment plan, consisting of multiple stages. Each stage
    /// may have a different deployment configuration and devices.
    pub fn createEdgeDeploymentPlan(self: *Self, allocator: std.mem.Allocator, input: create_edge_deployment_plan.CreateEdgeDeploymentPlanInput, options: create_edge_deployment_plan.Options) !create_edge_deployment_plan.CreateEdgeDeploymentPlanOutput {
        return create_edge_deployment_plan.execute(self, allocator, input, options);
    }

    /// Creates a new stage in an existing edge deployment plan.
    pub fn createEdgeDeploymentStage(self: *Self, allocator: std.mem.Allocator, input: create_edge_deployment_stage.CreateEdgeDeploymentStageInput, options: create_edge_deployment_stage.Options) !create_edge_deployment_stage.CreateEdgeDeploymentStageOutput {
        return create_edge_deployment_stage.execute(self, allocator, input, options);
    }

    /// Starts a SageMaker Edge Manager model packaging job. Edge Manager will use
    /// the model artifacts from the Amazon Simple Storage Service bucket that you
    /// specify. After the model has been packaged, Amazon SageMaker saves the
    /// resulting artifacts to an S3 bucket that you specify.
    pub fn createEdgePackagingJob(self: *Self, allocator: std.mem.Allocator, input: create_edge_packaging_job.CreateEdgePackagingJobInput, options: create_edge_packaging_job.Options) !create_edge_packaging_job.CreateEdgePackagingJobOutput {
        return create_edge_packaging_job.execute(self, allocator, input, options);
    }

    /// Creates an endpoint using the endpoint configuration specified in the
    /// request. SageMaker uses the endpoint to provision resources and deploy
    /// models. You create the endpoint configuration with the
    /// [CreateEndpointConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpointConfig.html) API.
    ///
    /// Use this API to deploy models using SageMaker hosting services.
    ///
    /// You must not delete an `EndpointConfig` that is in use by an endpoint that
    /// is live or while the `UpdateEndpoint` or `CreateEndpoint` operations are
    /// being performed on the endpoint. To update an endpoint, you must create a
    /// new `EndpointConfig`.
    ///
    /// The endpoint name must be unique within an Amazon Web Services Region in
    /// your Amazon Web Services account.
    ///
    /// When it receives the request, SageMaker creates the endpoint, launches the
    /// resources (ML compute instances), and deploys the model(s) on them.
    ///
    /// When you call
    /// [CreateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpoint.html), a load call is made to DynamoDB to verify that your endpoint configuration exists. When you read data from a DynamoDB table supporting [ `Eventually Consistent Reads` ](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.ReadConsistency.html), the response might not reflect the results of a recently completed write operation. The response might include some stale data. If the dependent entities are not yet in DynamoDB, this causes a validation error. If you repeat your read request after a short time, the response should return the latest data. So retry logic is recommended to handle these possible issues. We also recommend that customers call [DescribeEndpointConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeEndpointConfig.html) before calling [CreateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpoint.html) to minimize the potential impact of a DynamoDB eventually consistent read.
    ///
    /// When SageMaker receives the request, it sets the endpoint status to
    /// `Creating`. After it creates the endpoint, it sets the status to
    /// `InService`. SageMaker can then process incoming requests for inferences. To
    /// check the status of an endpoint, use the
    /// [DescribeEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeEndpoint.html) API.
    ///
    /// If any of the models hosted at this endpoint get model data from an Amazon
    /// S3 location, SageMaker uses Amazon Web Services Security Token Service to
    /// download model artifacts from the S3 path you provided. Amazon Web Services
    /// STS is activated in your Amazon Web Services account by default. If you
    /// previously deactivated Amazon Web Services STS for a region, you need to
    /// reactivate Amazon Web Services STS for that region. For more information,
    /// see [Activating and Deactivating Amazon Web Services STS in an Amazon Web
    /// Services
    /// Region](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html) in the *Amazon Web Services Identity and Access Management User Guide*.
    ///
    /// To add the IAM role policies for using this API operation, go to the [IAM
    /// console](https://console.aws.amazon.com/iam/), and choose Roles in the left
    /// navigation pane. Search the IAM role that you want to grant access to use
    /// the
    /// [CreateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpoint.html) and [CreateEndpointConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpointConfig.html) API operations, add the following policies to the role.
    ///
    /// * Option 1: For a full SageMaker access, search and attach the
    ///   `AmazonSageMakerFullAccess` policy.
    /// * Option 2: For granting a limited access to an IAM role, paste the
    ///   following Action elements manually into the JSON file of the IAM role:
    ///
    /// `"Action": ["sagemaker:CreateEndpoint", "sagemaker:CreateEndpointConfig"]`
    ///
    /// `"Resource": [`
    ///
    /// `"arn:aws:sagemaker:region:account-id:endpoint/endpointName"`
    ///
    /// `"arn:aws:sagemaker:region:account-id:endpoint-config/endpointConfigName"`
    ///
    /// `]`
    ///
    /// For more information, see [SageMaker API Permissions: Actions, Permissions,
    /// and Resources
    /// Reference](https://docs.aws.amazon.com/sagemaker/latest/dg/api-permissions-reference.html).
    pub fn createEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_endpoint.CreateEndpointInput, options: create_endpoint.Options) !create_endpoint.CreateEndpointOutput {
        return create_endpoint.execute(self, allocator, input, options);
    }

    /// Creates an endpoint configuration that SageMaker hosting services uses to
    /// deploy models. In the configuration, you identify one or more models,
    /// created using the `CreateModel` API, to deploy and the resources that you
    /// want SageMaker to provision. Then you call the
    /// [CreateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpoint.html) API.
    ///
    /// Use this API if you want to use SageMaker hosting services to deploy models
    /// into production.
    ///
    /// In the request, you define a `ProductionVariant`, for each model that you
    /// want to deploy. Each `ProductionVariant` parameter also describes the
    /// resources that you want SageMaker to provision. This includes the number and
    /// type of ML compute instances to deploy.
    ///
    /// If you are hosting multiple models, you also assign a `VariantWeight` to
    /// specify how much traffic you want to allocate to each model. For example,
    /// suppose that you want to host two models, A and B, and you assign traffic
    /// weight 2 for model A and 1 for model B. SageMaker distributes two-thirds of
    /// the traffic to Model A, and one-third to model B.
    ///
    /// When you call
    /// [CreateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpoint.html), a load call is made to DynamoDB to verify that your endpoint configuration exists. When you read data from a DynamoDB table supporting [ `Eventually Consistent Reads` ](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.ReadConsistency.html), the response might not reflect the results of a recently completed write operation. The response might include some stale data. If the dependent entities are not yet in DynamoDB, this causes a validation error. If you repeat your read request after a short time, the response should return the latest data. So retry logic is recommended to handle these possible issues. We also recommend that customers call [DescribeEndpointConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeEndpointConfig.html) before calling [CreateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpoint.html) to minimize the potential impact of a DynamoDB eventually consistent read.
    pub fn createEndpointConfig(self: *Self, allocator: std.mem.Allocator, input: create_endpoint_config.CreateEndpointConfigInput, options: create_endpoint_config.Options) !create_endpoint_config.CreateEndpointConfigOutput {
        return create_endpoint_config.execute(self, allocator, input, options);
    }

    /// Creates a SageMaker *experiment*. An experiment is a collection of *trials*
    /// that are observed, compared and evaluated as a group. A trial is a set of
    /// steps, called *trial components*, that produce a machine learning model.
    ///
    /// In the Studio UI, trials are referred to as *run groups* and trial
    /// components are referred to as *runs*.
    ///
    /// The goal of an experiment is to determine the components that produce the
    /// best model. Multiple trials are performed, each one isolating and measuring
    /// the impact of a change to one or more inputs, while keeping the remaining
    /// inputs constant.
    ///
    /// When you use SageMaker Studio or the SageMaker Python SDK, all experiments,
    /// trials, and trial components are automatically tracked, logged, and indexed.
    /// When you use the Amazon Web Services SDK for Python (Boto), you must use the
    /// logging APIs provided by the SDK.
    ///
    /// You can add tags to experiments, trials, trial components and then use the
    /// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API to search for the tags.
    ///
    /// To add a description to an experiment, specify the optional `Description`
    /// parameter. To add a description later, or to change the description, call
    /// the
    /// [UpdateExperiment](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateExperiment.html) API.
    ///
    /// To get a list of all your experiments, call the
    /// [ListExperiments](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ListExperiments.html) API. To view an experiment's properties, call the [DescribeExperiment](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeExperiment.html) API. To get a list of all the trials associated with an experiment, call the [ListTrials](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ListTrials.html) API. To create a trial call the [CreateTrial](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrial.html) API.
    pub fn createExperiment(self: *Self, allocator: std.mem.Allocator, input: create_experiment.CreateExperimentInput, options: create_experiment.Options) !create_experiment.CreateExperimentOutput {
        return create_experiment.execute(self, allocator, input, options);
    }

    /// Create a new `FeatureGroup`. A `FeatureGroup` is a group of `Features`
    /// defined in the `FeatureStore` to describe a `Record`.
    ///
    /// The `FeatureGroup` defines the schema and features contained in the
    /// `FeatureGroup`. A `FeatureGroup` definition is composed of a list of
    /// `Features`, a `RecordIdentifierFeatureName`, an `EventTimeFeatureName` and
    /// configurations for its `OnlineStore` and `OfflineStore`. Check [Amazon Web
    /// Services service
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html) to see the `FeatureGroup`s quota for your Amazon Web Services account.
    ///
    /// Note that it can take approximately 10-15 minutes to provision an
    /// `OnlineStore` `FeatureGroup` with the `InMemory` `StorageType`.
    ///
    /// You must include at least one of `OnlineStoreConfig` and
    /// `OfflineStoreConfig` to create a `FeatureGroup`.
    pub fn createFeatureGroup(self: *Self, allocator: std.mem.Allocator, input: create_feature_group.CreateFeatureGroupInput, options: create_feature_group.Options) !create_feature_group.CreateFeatureGroupOutput {
        return create_feature_group.execute(self, allocator, input, options);
    }

    /// Creates a flow definition.
    pub fn createFlowDefinition(self: *Self, allocator: std.mem.Allocator, input: create_flow_definition.CreateFlowDefinitionInput, options: create_flow_definition.Options) !create_flow_definition.CreateFlowDefinitionOutput {
        return create_flow_definition.execute(self, allocator, input, options);
    }

    /// Create a hub.
    pub fn createHub(self: *Self, allocator: std.mem.Allocator, input: create_hub.CreateHubInput, options: create_hub.Options) !create_hub.CreateHubOutput {
        return create_hub.execute(self, allocator, input, options);
    }

    /// Creates presigned URLs for accessing hub content artifacts. This operation
    /// generates time-limited, secure URLs that allow direct download of model
    /// artifacts and associated files from Amazon SageMaker hub content, including
    /// gated models that require end-user license agreement acceptance.
    pub fn createHubContentPresignedUrls(self: *Self, allocator: std.mem.Allocator, input: create_hub_content_presigned_urls.CreateHubContentPresignedUrlsInput, options: create_hub_content_presigned_urls.Options) !create_hub_content_presigned_urls.CreateHubContentPresignedUrlsOutput {
        return create_hub_content_presigned_urls.execute(self, allocator, input, options);
    }

    /// Create a hub content reference in order to add a model in the JumpStart
    /// public hub to a private hub.
    pub fn createHubContentReference(self: *Self, allocator: std.mem.Allocator, input: create_hub_content_reference.CreateHubContentReferenceInput, options: create_hub_content_reference.Options) !create_hub_content_reference.CreateHubContentReferenceOutput {
        return create_hub_content_reference.execute(self, allocator, input, options);
    }

    /// Defines the settings you will use for the human review workflow user
    /// interface. Reviewers will see a three-panel interface with an instruction
    /// area, the item to review, and an input area.
    pub fn createHumanTaskUi(self: *Self, allocator: std.mem.Allocator, input: create_human_task_ui.CreateHumanTaskUiInput, options: create_human_task_ui.Options) !create_human_task_ui.CreateHumanTaskUiOutput {
        return create_human_task_ui.execute(self, allocator, input, options);
    }

    /// Starts a hyperparameter tuning job. A hyperparameter tuning job finds the
    /// best version of a model by running many training jobs on your dataset using
    /// the algorithm you choose and values for hyperparameters within ranges that
    /// you specify. It then chooses the hyperparameter values that result in a
    /// model that performs the best, as measured by an objective metric that you
    /// choose.
    ///
    /// A hyperparameter tuning job automatically creates Amazon SageMaker
    /// experiments, trials, and trial components for each training job that it
    /// runs. You can view these entities in Amazon SageMaker Studio. For more
    /// information, see [View Experiments, Trials, and Trial
    /// Components](https://docs.aws.amazon.com/sagemaker/latest/dg/experiments-view-compare.html#experiments-view).
    ///
    /// Do not include any security-sensitive information including account access
    /// IDs, secrets, or tokens in any hyperparameter fields. As part of the shared
    /// responsibility model, you are responsible for any potential exposure,
    /// unauthorized access, or compromise of your sensitive data if caused by any
    /// security-sensitive information included in the request hyperparameter
    /// variable or plain text fields..
    pub fn createHyperParameterTuningJob(self: *Self, allocator: std.mem.Allocator, input: create_hyper_parameter_tuning_job.CreateHyperParameterTuningJobInput, options: create_hyper_parameter_tuning_job.Options) !create_hyper_parameter_tuning_job.CreateHyperParameterTuningJobOutput {
        return create_hyper_parameter_tuning_job.execute(self, allocator, input, options);
    }

    /// Creates a custom SageMaker AI image. A SageMaker AI image is a set of image
    /// versions. Each image version represents a container image stored in Amazon
    /// ECR. For more information, see [Bring your own SageMaker AI
    /// image](https://docs.aws.amazon.com/sagemaker/latest/dg/studio-byoi.html).
    pub fn createImage(self: *Self, allocator: std.mem.Allocator, input: create_image.CreateImageInput, options: create_image.Options) !create_image.CreateImageOutput {
        return create_image.execute(self, allocator, input, options);
    }

    /// Creates a version of the SageMaker AI image specified by `ImageName`. The
    /// version represents the Amazon ECR container image specified by `BaseImage`.
    pub fn createImageVersion(self: *Self, allocator: std.mem.Allocator, input: create_image_version.CreateImageVersionInput, options: create_image_version.Options) !create_image_version.CreateImageVersionOutput {
        return create_image_version.execute(self, allocator, input, options);
    }

    /// Creates an inference component, which is a SageMaker AI hosting object that
    /// you can use to deploy a model to an endpoint. In the inference component
    /// settings, you specify the model, the endpoint, and how the model utilizes
    /// the resources that the endpoint hosts. You can optimize resource utilization
    /// by tailoring how the required CPU cores, accelerators, and memory are
    /// allocated. You can deploy multiple inference components to an endpoint,
    /// where each inference component contains one model and the resource
    /// utilization needs for that individual model. After you deploy an inference
    /// component, you can directly invoke the associated model when you use the
    /// InvokeEndpoint API action.
    pub fn createInferenceComponent(self: *Self, allocator: std.mem.Allocator, input: create_inference_component.CreateInferenceComponentInput, options: create_inference_component.Options) !create_inference_component.CreateInferenceComponentOutput {
        return create_inference_component.execute(self, allocator, input, options);
    }

    /// Creates an inference experiment using the configurations specified in the
    /// request.
    ///
    /// Use this API to setup and schedule an experiment to compare model variants
    /// on a Amazon SageMaker inference endpoint. For more information about
    /// inference experiments, see [Shadow
    /// tests](https://docs.aws.amazon.com/sagemaker/latest/dg/shadow-tests.html).
    ///
    /// Amazon SageMaker begins your experiment at the scheduled time and routes
    /// traffic to your endpoint's model variants based on your specified
    /// configuration.
    ///
    /// While the experiment is in progress or after it has concluded, you can view
    /// metrics that compare your model variants. For more information, see [View,
    /// monitor, and edit shadow
    /// tests](https://docs.aws.amazon.com/sagemaker/latest/dg/shadow-tests-view-monitor-edit.html).
    pub fn createInferenceExperiment(self: *Self, allocator: std.mem.Allocator, input: create_inference_experiment.CreateInferenceExperimentInput, options: create_inference_experiment.Options) !create_inference_experiment.CreateInferenceExperimentOutput {
        return create_inference_experiment.execute(self, allocator, input, options);
    }

    /// Starts a recommendation job. You can create either an instance
    /// recommendation or load test job.
    pub fn createInferenceRecommendationsJob(self: *Self, allocator: std.mem.Allocator, input: create_inference_recommendations_job.CreateInferenceRecommendationsJobInput, options: create_inference_recommendations_job.Options) !create_inference_recommendations_job.CreateInferenceRecommendationsJobOutput {
        return create_inference_recommendations_job.execute(self, allocator, input, options);
    }

    /// Creates a job that uses workers to label the data objects in your input
    /// dataset. You can use the labeled data to train machine learning models.
    ///
    /// You can select your workforce from one of three providers:
    ///
    /// * A private workforce that you create. It can include employees,
    ///   contractors, and outside experts. Use a private workforce when want the
    ///   data to stay within your organization or when a specific set of skills is
    ///   required.
    /// * One or more vendors that you select from the Amazon Web Services
    ///   Marketplace. Vendors provide expertise in specific areas.
    /// * The Amazon Mechanical Turk workforce. This is the largest workforce, but
    ///   it should only be used for public data or data that has been stripped of
    ///   any personally identifiable information.
    ///
    /// You can also use *automated data labeling* to reduce the number of data
    /// objects that need to be labeled by a human. Automated data labeling uses
    /// *active learning* to determine if a data object can be labeled by machine or
    /// if it needs to be sent to a human worker. For more information, see [Using
    /// Automated Data
    /// Labeling](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-automated-labeling.html).
    ///
    /// The data objects to be labeled are contained in an Amazon S3 bucket. You
    /// create a *manifest file* that describes the location of each object. For
    /// more information, see [Using Input and Output
    /// Data](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-data.html).
    ///
    /// The output can be used as the manifest file for another labeling job or as
    /// training data for your machine learning models.
    ///
    /// You can use this operation to create a static labeling job or a streaming
    /// labeling job. A static labeling job stops if all data objects in the input
    /// manifest file identified in `ManifestS3Uri` have been labeled. A streaming
    /// labeling job runs perpetually until it is manually stopped, or remains idle
    /// for 10 days. You can send new data objects to an active (`InProgress`)
    /// streaming labeling job in real time. To learn how to create a static
    /// labeling job, see [Create a Labeling Job (API)
    /// ](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-create-labeling-job-api.html) in the Amazon SageMaker Developer Guide. To learn how to create a streaming labeling job, see [Create a Streaming Labeling Job](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-streaming-create-job.html).
    pub fn createLabelingJob(self: *Self, allocator: std.mem.Allocator, input: create_labeling_job.CreateLabelingJobInput, options: create_labeling_job.Options) !create_labeling_job.CreateLabelingJobOutput {
        return create_labeling_job.execute(self, allocator, input, options);
    }

    /// Creates an MLflow Tracking Server using a general purpose Amazon S3 bucket
    /// as the artifact store.
    pub fn createMlflowApp(self: *Self, allocator: std.mem.Allocator, input: create_mlflow_app.CreateMlflowAppInput, options: create_mlflow_app.Options) !create_mlflow_app.CreateMlflowAppOutput {
        return create_mlflow_app.execute(self, allocator, input, options);
    }

    /// Creates an MLflow Tracking Server using a general purpose Amazon S3 bucket
    /// as the artifact store. For more information, see [Create an MLflow Tracking
    /// Server](https://docs.aws.amazon.com/sagemaker/latest/dg/mlflow-create-tracking-server.html).
    pub fn createMlflowTrackingServer(self: *Self, allocator: std.mem.Allocator, input: create_mlflow_tracking_server.CreateMlflowTrackingServerInput, options: create_mlflow_tracking_server.Options) !create_mlflow_tracking_server.CreateMlflowTrackingServerOutput {
        return create_mlflow_tracking_server.execute(self, allocator, input, options);
    }

    /// Creates a model in SageMaker. In the request, you name the model and
    /// describe a primary container. For the primary container, you specify the
    /// Docker image that contains inference code, artifacts (from prior training),
    /// and a custom environment map that the inference code uses when you deploy
    /// the model for predictions.
    ///
    /// Use this API to create a model if you want to use SageMaker hosting services
    /// or run a batch transform job.
    ///
    /// To host your model, you create an endpoint configuration with the
    /// `CreateEndpointConfig` API, and then create an endpoint with the
    /// `CreateEndpoint` API. SageMaker then deploys all of the containers that you
    /// defined for the model in the hosting environment.
    ///
    /// To run a batch transform using your model, you start a job with the
    /// `CreateTransformJob` API. SageMaker uses your model and your dataset to get
    /// inferences which are then saved to a specified S3 location.
    ///
    /// In the request, you also provide an IAM role that SageMaker can assume to
    /// access model artifacts and docker image for deployment on ML compute hosting
    /// instances or for batch transform jobs. In addition, you also use the IAM
    /// role to manage permissions the inference code needs. For example, if the
    /// inference code access any other Amazon Web Services resources, you grant
    /// necessary permissions via this role.
    pub fn createModel(self: *Self, allocator: std.mem.Allocator, input: create_model.CreateModelInput, options: create_model.Options) !create_model.CreateModelOutput {
        return create_model.execute(self, allocator, input, options);
    }

    /// Creates the definition for a model bias job.
    pub fn createModelBiasJobDefinition(self: *Self, allocator: std.mem.Allocator, input: create_model_bias_job_definition.CreateModelBiasJobDefinitionInput, options: create_model_bias_job_definition.Options) !create_model_bias_job_definition.CreateModelBiasJobDefinitionOutput {
        return create_model_bias_job_definition.execute(self, allocator, input, options);
    }

    /// Creates an Amazon SageMaker Model Card.
    ///
    /// For information about how to use model cards, see [Amazon SageMaker Model
    /// Card](https://docs.aws.amazon.com/sagemaker/latest/dg/model-cards.html).
    pub fn createModelCard(self: *Self, allocator: std.mem.Allocator, input: create_model_card.CreateModelCardInput, options: create_model_card.Options) !create_model_card.CreateModelCardOutput {
        return create_model_card.execute(self, allocator, input, options);
    }

    /// Creates an Amazon SageMaker Model Card export job.
    pub fn createModelCardExportJob(self: *Self, allocator: std.mem.Allocator, input: create_model_card_export_job.CreateModelCardExportJobInput, options: create_model_card_export_job.Options) !create_model_card_export_job.CreateModelCardExportJobOutput {
        return create_model_card_export_job.execute(self, allocator, input, options);
    }

    /// Creates the definition for a model explainability job.
    pub fn createModelExplainabilityJobDefinition(self: *Self, allocator: std.mem.Allocator, input: create_model_explainability_job_definition.CreateModelExplainabilityJobDefinitionInput, options: create_model_explainability_job_definition.Options) !create_model_explainability_job_definition.CreateModelExplainabilityJobDefinitionOutput {
        return create_model_explainability_job_definition.execute(self, allocator, input, options);
    }

    /// Creates a model package that you can use to create SageMaker models or list
    /// on Amazon Web Services Marketplace, or a versioned model that is part of a
    /// model group. Buyers can subscribe to model packages listed on Amazon Web
    /// Services Marketplace to create models in SageMaker.
    ///
    /// To create a model package by specifying a Docker container that contains
    /// your inference code and the Amazon S3 location of your model artifacts,
    /// provide values for `InferenceSpecification`. To create a model from an
    /// algorithm resource that you created or subscribed to in Amazon Web Services
    /// Marketplace, provide a value for `SourceAlgorithmSpecification`.
    ///
    /// There are two types of model packages:
    ///
    /// * Versioned - a model that is part of a model group in the model registry.
    /// * Unversioned - a model package that is not part of a model group.
    pub fn createModelPackage(self: *Self, allocator: std.mem.Allocator, input: create_model_package.CreateModelPackageInput, options: create_model_package.Options) !create_model_package.CreateModelPackageOutput {
        return create_model_package.execute(self, allocator, input, options);
    }

    /// Creates a model group. A model group contains a group of model versions.
    pub fn createModelPackageGroup(self: *Self, allocator: std.mem.Allocator, input: create_model_package_group.CreateModelPackageGroupInput, options: create_model_package_group.Options) !create_model_package_group.CreateModelPackageGroupOutput {
        return create_model_package_group.execute(self, allocator, input, options);
    }

    /// Creates a definition for a job that monitors model quality and drift. For
    /// information about model monitor, see [Amazon SageMaker AI Model
    /// Monitor](https://docs.aws.amazon.com/sagemaker/latest/dg/model-monitor.html).
    pub fn createModelQualityJobDefinition(self: *Self, allocator: std.mem.Allocator, input: create_model_quality_job_definition.CreateModelQualityJobDefinitionInput, options: create_model_quality_job_definition.Options) !create_model_quality_job_definition.CreateModelQualityJobDefinitionOutput {
        return create_model_quality_job_definition.execute(self, allocator, input, options);
    }

    /// Creates a schedule that regularly starts Amazon SageMaker AI Processing Jobs
    /// to monitor the data captured for an Amazon SageMaker AI Endpoint.
    pub fn createMonitoringSchedule(self: *Self, allocator: std.mem.Allocator, input: create_monitoring_schedule.CreateMonitoringScheduleInput, options: create_monitoring_schedule.Options) !create_monitoring_schedule.CreateMonitoringScheduleOutput {
        return create_monitoring_schedule.execute(self, allocator, input, options);
    }

    /// Creates an SageMaker AI notebook instance. A notebook instance is a machine
    /// learning (ML) compute instance running on a Jupyter notebook.
    ///
    /// In a `CreateNotebookInstance` request, specify the type of ML compute
    /// instance that you want to run. SageMaker AI launches the instance, installs
    /// common libraries that you can use to explore datasets for model training,
    /// and attaches an ML storage volume to the notebook instance.
    ///
    /// SageMaker AI also provides a set of example notebooks. Each notebook
    /// demonstrates how to use SageMaker AI with a specific algorithm or with a
    /// machine learning framework.
    ///
    /// After receiving the request, SageMaker AI does the following:
    ///
    /// * Creates a network interface in the SageMaker AI VPC.
    /// * (Option) If you specified `SubnetId`, SageMaker AI creates a network
    ///   interface in your own VPC, which is inferred from the subnet ID that you
    ///   provide in the input. When creating this network interface, SageMaker AI
    ///   attaches the security group that you specified in the request to the
    ///   network interface that it creates in your VPC.
    /// * Launches an EC2 instance of the type specified in the request in the
    ///   SageMaker AI VPC. If you specified `SubnetId` of your VPC, SageMaker AI
    ///   specifies both network interfaces when launching this instance. This
    ///   enables inbound traffic from your own VPC to the notebook instance,
    ///   assuming that the security groups allow it.
    ///
    /// After creating the notebook instance, SageMaker AI returns its Amazon
    /// Resource Name (ARN). You can't change the name of a notebook instance after
    /// you create it.
    ///
    /// After SageMaker AI creates the notebook instance, you can connect to the
    /// Jupyter server and work in Jupyter notebooks. For example, you can write
    /// code to explore a dataset that you can use for model training, train a
    /// model, host models by creating SageMaker AI endpoints, and validate hosted
    /// models.
    ///
    /// For more information, see [How It
    /// Works](https://docs.aws.amazon.com/sagemaker/latest/dg/how-it-works.html).
    pub fn createNotebookInstance(self: *Self, allocator: std.mem.Allocator, input: create_notebook_instance.CreateNotebookInstanceInput, options: create_notebook_instance.Options) !create_notebook_instance.CreateNotebookInstanceOutput {
        return create_notebook_instance.execute(self, allocator, input, options);
    }

    /// Creates a lifecycle configuration that you can associate with a notebook
    /// instance. A *lifecycle configuration* is a collection of shell scripts that
    /// run when you create or start a notebook instance.
    ///
    /// Each lifecycle configuration script has a limit of 16384 characters.
    ///
    /// The value of the `$PATH` environment variable that is available to both
    /// scripts is `/sbin:bin:/usr/sbin:/usr/bin`.
    ///
    /// View Amazon CloudWatch Logs for notebook instance lifecycle configurations
    /// in log group `/aws/sagemaker/NotebookInstances` in log stream
    /// `[notebook-instance-name]/[LifecycleConfigHook]`.
    ///
    /// Lifecycle configuration scripts cannot run for longer than 5 minutes. If a
    /// script runs for longer than 5 minutes, it fails and the notebook instance is
    /// not created or started.
    ///
    /// For information about notebook instance lifestyle configurations, see [Step
    /// 2.1: (Optional) Customize a Notebook
    /// Instance](https://docs.aws.amazon.com/sagemaker/latest/dg/notebook-lifecycle-config.html).
    ///
    /// Lifecycle configuration scripts execute with root access and the notebook
    /// instance's IAM execution role privileges. Grant this permission only to
    /// trusted principals. See [Customize a Notebook Instance Using a Lifecycle
    /// Configuration
    /// Script](https://docs.aws.amazon.com/sagemaker/latest/dg/notebook-lifecycle-config.html) for security best practices.
    pub fn createNotebookInstanceLifecycleConfig(self: *Self, allocator: std.mem.Allocator, input: create_notebook_instance_lifecycle_config.CreateNotebookInstanceLifecycleConfigInput, options: create_notebook_instance_lifecycle_config.Options) !create_notebook_instance_lifecycle_config.CreateNotebookInstanceLifecycleConfigOutput {
        return create_notebook_instance_lifecycle_config.execute(self, allocator, input, options);
    }

    /// Creates a job that optimizes a model for inference performance. To create
    /// the job, you provide the location of a source model, and you provide the
    /// settings for the optimization techniques that you want the job to apply.
    /// When the job completes successfully, SageMaker uploads the new optimized
    /// model to the output destination that you specify.
    ///
    /// For more information about how to use this action, and about the supported
    /// optimization techniques, see [Optimize model inference with Amazon
    /// SageMaker](https://docs.aws.amazon.com/sagemaker/latest/dg/model-optimize.html).
    pub fn createOptimizationJob(self: *Self, allocator: std.mem.Allocator, input: create_optimization_job.CreateOptimizationJobInput, options: create_optimization_job.Options) !create_optimization_job.CreateOptimizationJobOutput {
        return create_optimization_job.execute(self, allocator, input, options);
    }

    /// Creates an Amazon SageMaker Partner AI App.
    pub fn createPartnerApp(self: *Self, allocator: std.mem.Allocator, input: create_partner_app.CreatePartnerAppInput, options: create_partner_app.Options) !create_partner_app.CreatePartnerAppOutput {
        return create_partner_app.execute(self, allocator, input, options);
    }

    /// Creates a presigned URL to access an Amazon SageMaker Partner AI App.
    pub fn createPartnerAppPresignedUrl(self: *Self, allocator: std.mem.Allocator, input: create_partner_app_presigned_url.CreatePartnerAppPresignedUrlInput, options: create_partner_app_presigned_url.Options) !create_partner_app_presigned_url.CreatePartnerAppPresignedUrlOutput {
        return create_partner_app_presigned_url.execute(self, allocator, input, options);
    }

    /// Creates a pipeline using a JSON pipeline definition.
    pub fn createPipeline(self: *Self, allocator: std.mem.Allocator, input: create_pipeline.CreatePipelineInput, options: create_pipeline.Options) !create_pipeline.CreatePipelineOutput {
        return create_pipeline.execute(self, allocator, input, options);
    }

    /// Creates a URL for a specified UserProfile in a Domain. When accessed in a
    /// web browser, the user will be automatically signed in to the domain, and
    /// granted access to all of the Apps and files associated with the Domain's
    /// Amazon Elastic File System volume. This operation can only be called when
    /// the authentication mode equals IAM.
    ///
    /// The IAM role or user passed to this API defines the permissions to access
    /// the app. Once the presigned URL is created, no additional permission is
    /// required to access this URL. IAM authorization policies for this API are
    /// also enforced for every HTTP request and WebSocket frame that attempts to
    /// connect to the app.
    ///
    /// You can restrict access to this API and to the URL that it returns to a list
    /// of IP addresses, Amazon VPCs or Amazon VPC Endpoints that you specify. For
    /// more information, see [Connect to Amazon SageMaker AI Studio Through an
    /// Interface VPC
    /// Endpoint](https://docs.aws.amazon.com/sagemaker/latest/dg/studio-interface-endpoint.html) .
    ///
    /// * The URL that you get from a call to `CreatePresignedDomainUrl` has a
    ///   default timeout of 5 minutes. You can configure this value using
    ///   `ExpiresInSeconds`. If you try to use the URL after the timeout limit
    ///   expires, you are directed to the Amazon Web Services console sign-in page.
    /// * The JupyterLab session default expiration time is 12 hours. You can
    ///   configure this value using SessionExpirationDurationInSeconds.
    pub fn createPresignedDomainUrl(self: *Self, allocator: std.mem.Allocator, input: create_presigned_domain_url.CreatePresignedDomainUrlInput, options: create_presigned_domain_url.Options) !create_presigned_domain_url.CreatePresignedDomainUrlOutput {
        return create_presigned_domain_url.execute(self, allocator, input, options);
    }

    /// Returns a presigned URL that you can use to connect to the MLflow UI
    /// attached to your MLflow App. For more information, see [Launch the MLflow UI
    /// using a presigned
    /// URL](https://docs.aws.amazon.com/sagemaker/latest/dg/mlflow-launch-ui.html).
    pub fn createPresignedMlflowAppUrl(self: *Self, allocator: std.mem.Allocator, input: create_presigned_mlflow_app_url.CreatePresignedMlflowAppUrlInput, options: create_presigned_mlflow_app_url.Options) !create_presigned_mlflow_app_url.CreatePresignedMlflowAppUrlOutput {
        return create_presigned_mlflow_app_url.execute(self, allocator, input, options);
    }

    /// Returns a presigned URL that you can use to connect to the MLflow UI
    /// attached to your tracking server. For more information, see [Launch the
    /// MLflow UI using a presigned
    /// URL](https://docs.aws.amazon.com/sagemaker/latest/dg/mlflow-launch-ui.html).
    pub fn createPresignedMlflowTrackingServerUrl(self: *Self, allocator: std.mem.Allocator, input: create_presigned_mlflow_tracking_server_url.CreatePresignedMlflowTrackingServerUrlInput, options: create_presigned_mlflow_tracking_server_url.Options) !create_presigned_mlflow_tracking_server_url.CreatePresignedMlflowTrackingServerUrlOutput {
        return create_presigned_mlflow_tracking_server_url.execute(self, allocator, input, options);
    }

    /// Returns a URL that you can use to connect to the Jupyter server from a
    /// notebook instance. In the SageMaker AI console, when you choose `Open` next
    /// to a notebook instance, SageMaker AI opens a new tab showing the Jupyter
    /// server home page from the notebook instance. The console uses this API to
    /// get the URL and show the page.
    ///
    /// The IAM role or user used to call this API defines the permissions to access
    /// the notebook instance. Once the presigned URL is created, no additional
    /// permission is required to access this URL. IAM authorization policies for
    /// this API are also enforced for every HTTP request and WebSocket frame that
    /// attempts to connect to the notebook instance.
    ///
    /// You can restrict access to this API and to the URL that it returns to a list
    /// of IP addresses that you specify. Use the `NotIpAddress` condition operator
    /// and the `aws:SourceIP` condition context key to specify the list of IP
    /// addresses that you want to have access to the notebook instance. For more
    /// information, see [Limit Access to a Notebook Instance by IP
    /// Address](https://docs.aws.amazon.com/sagemaker/latest/dg/security_iam_id-based-policy-examples.html#nbi-ip-filter).
    ///
    /// The URL that you get from a call to
    /// [CreatePresignedNotebookInstanceUrl](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreatePresignedNotebookInstanceUrl.html) is valid only for 5 minutes. If you try to use the URL after the 5-minute limit expires, you are directed to the Amazon Web Services console sign-in page.
    pub fn createPresignedNotebookInstanceUrl(self: *Self, allocator: std.mem.Allocator, input: create_presigned_notebook_instance_url.CreatePresignedNotebookInstanceUrlInput, options: create_presigned_notebook_instance_url.Options) !create_presigned_notebook_instance_url.CreatePresignedNotebookInstanceUrlOutput {
        return create_presigned_notebook_instance_url.execute(self, allocator, input, options);
    }

    /// Creates a processing job.
    pub fn createProcessingJob(self: *Self, allocator: std.mem.Allocator, input: create_processing_job.CreateProcessingJobInput, options: create_processing_job.Options) !create_processing_job.CreateProcessingJobOutput {
        return create_processing_job.execute(self, allocator, input, options);
    }

    /// Creates a machine learning (ML) project that can contain one or more
    /// templates that set up an ML pipeline from training to deploying an approved
    /// model.
    pub fn createProject(self: *Self, allocator: std.mem.Allocator, input: create_project.CreateProjectInput, options: create_project.Options) !create_project.CreateProjectOutput {
        return create_project.execute(self, allocator, input, options);
    }

    /// Creates a private space or a space used for real time collaboration in a
    /// domain.
    pub fn createSpace(self: *Self, allocator: std.mem.Allocator, input: create_space.CreateSpaceInput, options: create_space.Options) !create_space.CreateSpaceOutput {
        return create_space.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon SageMaker AI Studio Lifecycle Configuration.
    pub fn createStudioLifecycleConfig(self: *Self, allocator: std.mem.Allocator, input: create_studio_lifecycle_config.CreateStudioLifecycleConfigInput, options: create_studio_lifecycle_config.Options) !create_studio_lifecycle_config.CreateStudioLifecycleConfigOutput {
        return create_studio_lifecycle_config.execute(self, allocator, input, options);
    }

    /// Starts a model training job. After training completes, SageMaker saves the
    /// resulting model artifacts to an Amazon S3 location that you specify.
    ///
    /// If you choose to host your model using SageMaker hosting services, you can
    /// use the resulting model artifacts as part of the model. You can also use the
    /// artifacts in a machine learning service other than SageMaker, provided that
    /// you know how to use them for inference.
    ///
    /// In the request body, you provide the following:
    ///
    /// * `AlgorithmSpecification` - Identifies the training algorithm to use.
    /// * `HyperParameters` - Specify these algorithm-specific parameters to enable
    ///   the estimation of model parameters during training. Hyperparameters can be
    ///   tuned to optimize this learning process. For a list of hyperparameters for
    ///   each training algorithm provided by SageMaker, see
    ///   [Algorithms](https://docs.aws.amazon.com/sagemaker/latest/dg/algos.html).
    ///
    /// Do not include any security-sensitive information including account access
    /// IDs, secrets, or tokens in any hyperparameter fields. As part of the shared
    /// responsibility model, you are responsible for any potential exposure,
    /// unauthorized access, or compromise of your sensitive data if caused by
    /// security-sensitive information included in the request hyperparameter
    /// variable or plain text fields.
    /// * `InputDataConfig` - Describes the input required by the training job and
    ///   the Amazon S3, EFS, or FSx location where it is stored.
    /// * `OutputDataConfig` - Identifies the Amazon S3 bucket where you want
    ///   SageMaker to save the results of model training.
    /// * `ResourceConfig` - Identifies the resources, ML compute instances, and ML
    ///   storage volumes to deploy for model training. In distributed training, you
    ///   specify more than one instance.
    /// * `EnableManagedSpotTraining` - Optimize the cost of training machine
    ///   learning models by up to 80% by using Amazon EC2 Spot instances. For more
    ///   information, see [Managed Spot
    ///   Training](https://docs.aws.amazon.com/sagemaker/latest/dg/model-managed-spot-training.html).
    /// * `RoleArn` - The Amazon Resource Name (ARN) that SageMaker assumes to
    ///   perform tasks on your behalf during model training. You must grant this
    ///   role the necessary permissions so that SageMaker can successfully complete
    ///   model training.
    /// * `StoppingCondition` - To help cap training costs, use
    ///   `MaxRuntimeInSeconds` to set a time limit for training. Use
    ///   `MaxWaitTimeInSeconds` to specify how long a managed spot training job has
    ///   to complete.
    /// * `Environment` - The environment variables to set in the Docker container.
    ///
    /// Do not include any security-sensitive information including account access
    /// IDs, secrets, or tokens in any environment fields. As part of the shared
    /// responsibility model, you are responsible for any potential exposure,
    /// unauthorized access, or compromise of your sensitive data if caused by
    /// security-sensitive information included in the request environment variable
    /// or plain text fields.
    /// * `RetryStrategy` - The number of times to retry the job when the job fails
    ///   due to an `InternalServerError`.
    ///
    /// For more information about SageMaker, see [How It
    /// Works](https://docs.aws.amazon.com/sagemaker/latest/dg/how-it-works.html).
    pub fn createTrainingJob(self: *Self, allocator: std.mem.Allocator, input: create_training_job.CreateTrainingJobInput, options: create_training_job.Options) !create_training_job.CreateTrainingJobOutput {
        return create_training_job.execute(self, allocator, input, options);
    }

    /// Creates a new training plan in SageMaker to reserve compute capacity.
    ///
    /// Amazon SageMaker Training Plan is a capability within SageMaker that allows
    /// customers to reserve and manage GPU capacity for large-scale AI model
    /// training. It provides a way to secure predictable access to computational
    /// resources within specific timelines and budgets, without the need to manage
    /// underlying infrastructure.
    ///
    /// **How it works**
    ///
    /// Plans can be created for specific resources such as SageMaker Training Jobs
    /// or SageMaker HyperPod clusters, automatically provisioning resources,
    /// setting up infrastructure, executing workloads, and handling infrastructure
    /// failures.
    ///
    /// **Plan creation workflow**
    ///
    /// * Users search for available plan offerings based on their requirements
    ///   (e.g., instance type, count, start time, duration) using the `
    ///   [SearchTrainingPlanOfferings](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_SearchTrainingPlanOfferings.html) ` API operation.
    /// * They create a plan that best matches their needs using the ID of the plan
    ///   offering they want to use.
    /// * After successful upfront payment, the plan's status becomes `Scheduled`.
    /// * The plan can be used to:
    ///
    /// * Queue training jobs.
    /// * Allocate to an instance group of a SageMaker HyperPod cluster.
    ///
    /// * When the plan start date arrives, it becomes `Active`. Based on available
    ///   reserved capacity:
    ///
    /// * Training jobs are launched.
    /// * Instance groups are provisioned.
    ///
    /// **Plan composition**
    ///
    /// A plan can consist of one or more Reserved Capacities, each defined by a
    /// specific instance type, quantity, Availability Zone, duration, and start and
    /// end times. For more information about Reserved Capacity, see `
    /// [ReservedCapacitySummary](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ReservedCapacitySummary.html) `.
    pub fn createTrainingPlan(self: *Self, allocator: std.mem.Allocator, input: create_training_plan.CreateTrainingPlanInput, options: create_training_plan.Options) !create_training_plan.CreateTrainingPlanOutput {
        return create_training_plan.execute(self, allocator, input, options);
    }

    /// Starts a transform job. A transform job uses a trained model to get
    /// inferences on a dataset and saves these results to an Amazon S3 location
    /// that you specify.
    ///
    /// To perform batch transformations, you create a transform job and use the
    /// data that you have readily available.
    ///
    /// In the request body, you provide the following:
    ///
    /// * `TransformJobName` - Identifies the transform job. The name must be unique
    ///   within an Amazon Web Services Region in an Amazon Web Services account.
    /// * `ModelName` - Identifies the model to use. `ModelName` must be the name of
    ///   an existing Amazon SageMaker model in the same Amazon Web Services Region
    ///   and Amazon Web Services account. For information on creating a model, see
    ///   [CreateModel](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateModel.html).
    /// * `TransformInput` - Describes the dataset to be transformed and the Amazon
    ///   S3 location where it is stored.
    /// * `TransformOutput` - Identifies the Amazon S3 location where you want
    ///   Amazon SageMaker to save the results from the transform job.
    /// * `TransformResources` - Identifies the ML compute instances and AMI image
    ///   versions for the transform job.
    ///
    /// For more information about how batch transformation works, see [Batch
    /// Transform](https://docs.aws.amazon.com/sagemaker/latest/dg/batch-transform.html).
    pub fn createTransformJob(self: *Self, allocator: std.mem.Allocator, input: create_transform_job.CreateTransformJobInput, options: create_transform_job.Options) !create_transform_job.CreateTransformJobOutput {
        return create_transform_job.execute(self, allocator, input, options);
    }

    /// Creates an SageMaker *trial*. A trial is a set of steps called *trial
    /// components* that produce a machine learning model. A trial is part of a
    /// single SageMaker *experiment*.
    ///
    /// When you use SageMaker Studio or the SageMaker Python SDK, all experiments,
    /// trials, and trial components are automatically tracked, logged, and indexed.
    /// When you use the Amazon Web Services SDK for Python (Boto), you must use the
    /// logging APIs provided by the SDK.
    ///
    /// You can add tags to a trial and then use the
    /// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API to search for the tags.
    ///
    /// To get a list of all your trials, call the
    /// [ListTrials](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ListTrials.html) API. To view a trial's properties, call the [DescribeTrial](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeTrial.html) API. To create a trial component, call the [CreateTrialComponent](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrialComponent.html) API.
    pub fn createTrial(self: *Self, allocator: std.mem.Allocator, input: create_trial.CreateTrialInput, options: create_trial.Options) !create_trial.CreateTrialOutput {
        return create_trial.execute(self, allocator, input, options);
    }

    /// Creates a *trial component*, which is a stage of a machine learning *trial*.
    /// A trial is composed of one or more trial components. A trial component can
    /// be used in multiple trials.
    ///
    /// Trial components include pre-processing jobs, training jobs, and batch
    /// transform jobs.
    ///
    /// When you use SageMaker Studio or the SageMaker Python SDK, all experiments,
    /// trials, and trial components are automatically tracked, logged, and indexed.
    /// When you use the Amazon Web Services SDK for Python (Boto), you must use the
    /// logging APIs provided by the SDK.
    ///
    /// You can add tags to a trial component and then use the
    /// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API to search for the tags.
    pub fn createTrialComponent(self: *Self, allocator: std.mem.Allocator, input: create_trial_component.CreateTrialComponentInput, options: create_trial_component.Options) !create_trial_component.CreateTrialComponentOutput {
        return create_trial_component.execute(self, allocator, input, options);
    }

    /// Creates a user profile. A user profile represents a single user within a
    /// domain, and is the main way to reference a "person" for the purposes of
    /// sharing, reporting, and other user-oriented features. This entity is created
    /// when a user onboards to a domain. If an administrator invites a person by
    /// email or imports them from IAM Identity Center, a user profile is
    /// automatically created. A user profile is the primary holder of settings for
    /// an individual user and has a reference to the user's private Amazon Elastic
    /// File System home directory.
    pub fn createUserProfile(self: *Self, allocator: std.mem.Allocator, input: create_user_profile.CreateUserProfileInput, options: create_user_profile.Options) !create_user_profile.CreateUserProfileOutput {
        return create_user_profile.execute(self, allocator, input, options);
    }

    /// Use this operation to create a workforce. This operation will return an
    /// error if a workforce already exists in the Amazon Web Services Region that
    /// you specify. You can only create one workforce in each Amazon Web Services
    /// Region per Amazon Web Services account.
    ///
    /// If you want to create a new workforce in an Amazon Web Services Region where
    /// a workforce already exists, use the
    /// [DeleteWorkforce](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DeleteWorkforce.html) API operation to delete the existing workforce and then use `CreateWorkforce` to create a new workforce.
    ///
    /// To create a private workforce using Amazon Cognito, you must specify a
    /// Cognito user pool in `CognitoConfig`. You can also create an Amazon Cognito
    /// workforce using the Amazon SageMaker console. For more information, see [
    /// Create a Private Workforce (Amazon
    /// Cognito)](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-workforce-create-private.html).
    ///
    /// To create a private workforce using your own OIDC Identity Provider (IdP),
    /// specify your IdP configuration in `OidcConfig`. Your OIDC IdP must support
    /// *groups* because groups are used by Ground Truth and Amazon A2I to create
    /// work teams. For more information, see [ Create a Private Workforce (OIDC
    /// IdP)](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-workforce-create-private-oidc.html).
    pub fn createWorkforce(self: *Self, allocator: std.mem.Allocator, input: create_workforce.CreateWorkforceInput, options: create_workforce.Options) !create_workforce.CreateWorkforceOutput {
        return create_workforce.execute(self, allocator, input, options);
    }

    /// Creates a new work team for labeling your data. A work team is defined by
    /// one or more Amazon Cognito user pools. You must first create the user pools
    /// before you can create a work team.
    ///
    /// You cannot create more than 25 work teams in an account and region.
    pub fn createWorkteam(self: *Self, allocator: std.mem.Allocator, input: create_workteam.CreateWorkteamInput, options: create_workteam.Options) !create_workteam.CreateWorkteamOutput {
        return create_workteam.execute(self, allocator, input, options);
    }

    /// Deletes an action.
    pub fn deleteAction(self: *Self, allocator: std.mem.Allocator, input: delete_action.DeleteActionInput, options: delete_action.Options) !delete_action.DeleteActionOutput {
        return delete_action.execute(self, allocator, input, options);
    }

    /// Removes the specified algorithm from your account.
    pub fn deleteAlgorithm(self: *Self, allocator: std.mem.Allocator, input: delete_algorithm.DeleteAlgorithmInput, options: delete_algorithm.Options) !delete_algorithm.DeleteAlgorithmOutput {
        return delete_algorithm.execute(self, allocator, input, options);
    }

    /// Used to stop and delete an app.
    pub fn deleteApp(self: *Self, allocator: std.mem.Allocator, input: delete_app.DeleteAppInput, options: delete_app.Options) !delete_app.DeleteAppOutput {
        return delete_app.execute(self, allocator, input, options);
    }

    /// Deletes an AppImageConfig.
    pub fn deleteAppImageConfig(self: *Self, allocator: std.mem.Allocator, input: delete_app_image_config.DeleteAppImageConfigInput, options: delete_app_image_config.Options) !delete_app_image_config.DeleteAppImageConfigOutput {
        return delete_app_image_config.execute(self, allocator, input, options);
    }

    /// Deletes an artifact. Either `ArtifactArn` or `Source` must be specified.
    pub fn deleteArtifact(self: *Self, allocator: std.mem.Allocator, input: delete_artifact.DeleteArtifactInput, options: delete_artifact.Options) !delete_artifact.DeleteArtifactOutput {
        return delete_artifact.execute(self, allocator, input, options);
    }

    /// Deletes an association.
    pub fn deleteAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_association.DeleteAssociationInput, options: delete_association.Options) !delete_association.DeleteAssociationOutput {
        return delete_association.execute(self, allocator, input, options);
    }

    /// Delete a SageMaker HyperPod cluster.
    pub fn deleteCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cluster.DeleteClusterInput, options: delete_cluster.Options) !delete_cluster.DeleteClusterOutput {
        return delete_cluster.execute(self, allocator, input, options);
    }

    /// Deletes the cluster policy of the cluster.
    pub fn deleteClusterSchedulerConfig(self: *Self, allocator: std.mem.Allocator, input: delete_cluster_scheduler_config.DeleteClusterSchedulerConfigInput, options: delete_cluster_scheduler_config.Options) !delete_cluster_scheduler_config.DeleteClusterSchedulerConfigOutput {
        return delete_cluster_scheduler_config.execute(self, allocator, input, options);
    }

    /// Deletes the specified Git repository from your account.
    pub fn deleteCodeRepository(self: *Self, allocator: std.mem.Allocator, input: delete_code_repository.DeleteCodeRepositoryInput, options: delete_code_repository.Options) !delete_code_repository.DeleteCodeRepositoryOutput {
        return delete_code_repository.execute(self, allocator, input, options);
    }

    /// Deletes the specified compilation job. This action deletes only the
    /// compilation job resource in Amazon SageMaker AI. It doesn't delete other
    /// resources that are related to that job, such as the model artifacts that the
    /// job creates, the compilation logs in CloudWatch, the compiled model, or the
    /// IAM role.
    ///
    /// You can delete a compilation job only if its current status is `COMPLETED`,
    /// `FAILED`, or `STOPPED`. If the job status is `STARTING` or `INPROGRESS`,
    /// stop the job, and then delete it after its status becomes `STOPPED`.
    pub fn deleteCompilationJob(self: *Self, allocator: std.mem.Allocator, input: delete_compilation_job.DeleteCompilationJobInput, options: delete_compilation_job.Options) !delete_compilation_job.DeleteCompilationJobOutput {
        return delete_compilation_job.execute(self, allocator, input, options);
    }

    /// Deletes the compute allocation from the cluster.
    pub fn deleteComputeQuota(self: *Self, allocator: std.mem.Allocator, input: delete_compute_quota.DeleteComputeQuotaInput, options: delete_compute_quota.Options) !delete_compute_quota.DeleteComputeQuotaOutput {
        return delete_compute_quota.execute(self, allocator, input, options);
    }

    /// Deletes an context.
    pub fn deleteContext(self: *Self, allocator: std.mem.Allocator, input: delete_context.DeleteContextInput, options: delete_context.Options) !delete_context.DeleteContextOutput {
        return delete_context.execute(self, allocator, input, options);
    }

    /// Deletes a data quality monitoring job definition.
    pub fn deleteDataQualityJobDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_data_quality_job_definition.DeleteDataQualityJobDefinitionInput, options: delete_data_quality_job_definition.Options) !delete_data_quality_job_definition.DeleteDataQualityJobDefinitionOutput {
        return delete_data_quality_job_definition.execute(self, allocator, input, options);
    }

    /// Deletes a fleet.
    pub fn deleteDeviceFleet(self: *Self, allocator: std.mem.Allocator, input: delete_device_fleet.DeleteDeviceFleetInput, options: delete_device_fleet.Options) !delete_device_fleet.DeleteDeviceFleetOutput {
        return delete_device_fleet.execute(self, allocator, input, options);
    }

    /// Used to delete a domain. If you onboarded with IAM mode, you will need to
    /// delete your domain to onboard again using IAM Identity Center. Use with
    /// caution. All of the members of the domain will lose access to their EFS
    /// volume, including data, notebooks, and other artifacts.
    pub fn deleteDomain(self: *Self, allocator: std.mem.Allocator, input: delete_domain.DeleteDomainInput, options: delete_domain.Options) !delete_domain.DeleteDomainOutput {
        return delete_domain.execute(self, allocator, input, options);
    }

    /// Deletes an edge deployment plan if (and only if) all the stages in the plan
    /// are inactive or there are no stages in the plan.
    pub fn deleteEdgeDeploymentPlan(self: *Self, allocator: std.mem.Allocator, input: delete_edge_deployment_plan.DeleteEdgeDeploymentPlanInput, options: delete_edge_deployment_plan.Options) !delete_edge_deployment_plan.DeleteEdgeDeploymentPlanOutput {
        return delete_edge_deployment_plan.execute(self, allocator, input, options);
    }

    /// Delete a stage in an edge deployment plan if (and only if) the stage is
    /// inactive.
    pub fn deleteEdgeDeploymentStage(self: *Self, allocator: std.mem.Allocator, input: delete_edge_deployment_stage.DeleteEdgeDeploymentStageInput, options: delete_edge_deployment_stage.Options) !delete_edge_deployment_stage.DeleteEdgeDeploymentStageOutput {
        return delete_edge_deployment_stage.execute(self, allocator, input, options);
    }

    /// Deletes an endpoint. SageMaker frees up all of the resources that were
    /// deployed when the endpoint was created.
    ///
    /// SageMaker retires any custom KMS key grants associated with the endpoint,
    /// meaning you don't need to use the
    /// [RevokeGrant](http://docs.aws.amazon.com/kms/latest/APIReference/API_RevokeGrant.html) API call.
    ///
    /// When you delete your endpoint, SageMaker asynchronously deletes associated
    /// endpoint resources such as KMS key grants. You might still see these
    /// resources in your account for a few minutes after deleting your endpoint. Do
    /// not delete or revoke the permissions for your `
    /// [ExecutionRoleArn](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateModel.html#sagemaker-CreateModel-request-ExecutionRoleArn) `, otherwise SageMaker cannot delete these resources.
    pub fn deleteEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_endpoint.DeleteEndpointInput, options: delete_endpoint.Options) !delete_endpoint.DeleteEndpointOutput {
        return delete_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes an endpoint configuration. The `DeleteEndpointConfig` API deletes
    /// only the specified configuration. It does not delete endpoints created using
    /// the configuration.
    ///
    /// You must not delete an `EndpointConfig` in use by an endpoint that is live
    /// or while the `UpdateEndpoint` or `CreateEndpoint` operations are being
    /// performed on the endpoint. If you delete the `EndpointConfig` of an endpoint
    /// that is active or being created or updated you may lose visibility into the
    /// instance type the endpoint is using. The endpoint must be deleted in order
    /// to stop incurring charges.
    pub fn deleteEndpointConfig(self: *Self, allocator: std.mem.Allocator, input: delete_endpoint_config.DeleteEndpointConfigInput, options: delete_endpoint_config.Options) !delete_endpoint_config.DeleteEndpointConfigOutput {
        return delete_endpoint_config.execute(self, allocator, input, options);
    }

    /// Deletes an SageMaker experiment. All trials associated with the experiment
    /// must be deleted first. Use the
    /// [ListTrials](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ListTrials.html) API to get a list of the trials associated with the experiment.
    pub fn deleteExperiment(self: *Self, allocator: std.mem.Allocator, input: delete_experiment.DeleteExperimentInput, options: delete_experiment.Options) !delete_experiment.DeleteExperimentOutput {
        return delete_experiment.execute(self, allocator, input, options);
    }

    /// Delete the `FeatureGroup` and any data that was written to the `OnlineStore`
    /// of the `FeatureGroup`. Data cannot be accessed from the `OnlineStore`
    /// immediately after `DeleteFeatureGroup` is called.
    ///
    /// Data written into the `OfflineStore` will not be deleted. The Amazon Web
    /// Services Glue database and tables that are automatically created for your
    /// `OfflineStore` are not deleted.
    ///
    /// Note that it can take approximately 10-15 minutes to delete an `OnlineStore`
    /// `FeatureGroup` with the `InMemory` `StorageType`.
    pub fn deleteFeatureGroup(self: *Self, allocator: std.mem.Allocator, input: delete_feature_group.DeleteFeatureGroupInput, options: delete_feature_group.Options) !delete_feature_group.DeleteFeatureGroupOutput {
        return delete_feature_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified flow definition.
    pub fn deleteFlowDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_flow_definition.DeleteFlowDefinitionInput, options: delete_flow_definition.Options) !delete_flow_definition.DeleteFlowDefinitionOutput {
        return delete_flow_definition.execute(self, allocator, input, options);
    }

    /// Delete a hub.
    pub fn deleteHub(self: *Self, allocator: std.mem.Allocator, input: delete_hub.DeleteHubInput, options: delete_hub.Options) !delete_hub.DeleteHubOutput {
        return delete_hub.execute(self, allocator, input, options);
    }

    /// Delete the contents of a hub.
    pub fn deleteHubContent(self: *Self, allocator: std.mem.Allocator, input: delete_hub_content.DeleteHubContentInput, options: delete_hub_content.Options) !delete_hub_content.DeleteHubContentOutput {
        return delete_hub_content.execute(self, allocator, input, options);
    }

    /// Delete a hub content reference in order to remove a model from a private
    /// hub.
    pub fn deleteHubContentReference(self: *Self, allocator: std.mem.Allocator, input: delete_hub_content_reference.DeleteHubContentReferenceInput, options: delete_hub_content_reference.Options) !delete_hub_content_reference.DeleteHubContentReferenceOutput {
        return delete_hub_content_reference.execute(self, allocator, input, options);
    }

    /// Use this operation to delete a human task user interface (worker task
    /// template).
    ///
    /// To see a list of human task user interfaces (work task templates) in your
    /// account, use
    /// [ListHumanTaskUis](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ListHumanTaskUis.html). When you delete a worker task template, it no longer appears when you call `ListHumanTaskUis`.
    pub fn deleteHumanTaskUi(self: *Self, allocator: std.mem.Allocator, input: delete_human_task_ui.DeleteHumanTaskUiInput, options: delete_human_task_ui.Options) !delete_human_task_ui.DeleteHumanTaskUiOutput {
        return delete_human_task_ui.execute(self, allocator, input, options);
    }

    /// Deletes a hyperparameter tuning job. The `DeleteHyperParameterTuningJob` API
    /// deletes only the tuning job entry that was created in SageMaker when you
    /// called the `CreateHyperParameterTuningJob` API. It does not delete training
    /// jobs, artifacts, or the IAM role that you specified when creating the model.
    pub fn deleteHyperParameterTuningJob(self: *Self, allocator: std.mem.Allocator, input: delete_hyper_parameter_tuning_job.DeleteHyperParameterTuningJobInput, options: delete_hyper_parameter_tuning_job.Options) !delete_hyper_parameter_tuning_job.DeleteHyperParameterTuningJobOutput {
        return delete_hyper_parameter_tuning_job.execute(self, allocator, input, options);
    }

    /// Deletes a SageMaker AI image and all versions of the image. The container
    /// images aren't deleted.
    pub fn deleteImage(self: *Self, allocator: std.mem.Allocator, input: delete_image.DeleteImageInput, options: delete_image.Options) !delete_image.DeleteImageOutput {
        return delete_image.execute(self, allocator, input, options);
    }

    /// Deletes a version of a SageMaker AI image. The container image the version
    /// represents isn't deleted.
    pub fn deleteImageVersion(self: *Self, allocator: std.mem.Allocator, input: delete_image_version.DeleteImageVersionInput, options: delete_image_version.Options) !delete_image_version.DeleteImageVersionOutput {
        return delete_image_version.execute(self, allocator, input, options);
    }

    /// Deletes an inference component.
    pub fn deleteInferenceComponent(self: *Self, allocator: std.mem.Allocator, input: delete_inference_component.DeleteInferenceComponentInput, options: delete_inference_component.Options) !delete_inference_component.DeleteInferenceComponentOutput {
        return delete_inference_component.execute(self, allocator, input, options);
    }

    /// Deletes an inference experiment.
    ///
    /// This operation does not delete your endpoint, variants, or any underlying
    /// resources. This operation only deletes the metadata of your experiment.
    pub fn deleteInferenceExperiment(self: *Self, allocator: std.mem.Allocator, input: delete_inference_experiment.DeleteInferenceExperimentInput, options: delete_inference_experiment.Options) !delete_inference_experiment.DeleteInferenceExperimentOutput {
        return delete_inference_experiment.execute(self, allocator, input, options);
    }

    /// Deletes an MLflow App.
    pub fn deleteMlflowApp(self: *Self, allocator: std.mem.Allocator, input: delete_mlflow_app.DeleteMlflowAppInput, options: delete_mlflow_app.Options) !delete_mlflow_app.DeleteMlflowAppOutput {
        return delete_mlflow_app.execute(self, allocator, input, options);
    }

    /// Deletes an MLflow Tracking Server. For more information, see [Clean up
    /// MLflow
    /// resources](https://docs.aws.amazon.com/sagemaker/latest/dg/mlflow-cleanup.html.html).
    pub fn deleteMlflowTrackingServer(self: *Self, allocator: std.mem.Allocator, input: delete_mlflow_tracking_server.DeleteMlflowTrackingServerInput, options: delete_mlflow_tracking_server.Options) !delete_mlflow_tracking_server.DeleteMlflowTrackingServerOutput {
        return delete_mlflow_tracking_server.execute(self, allocator, input, options);
    }

    /// Deletes a model. The `DeleteModel` API deletes only the model entry that was
    /// created in SageMaker when you called the `CreateModel` API. It does not
    /// delete model artifacts, inference code, or the IAM role that you specified
    /// when creating the model.
    pub fn deleteModel(self: *Self, allocator: std.mem.Allocator, input: delete_model.DeleteModelInput, options: delete_model.Options) !delete_model.DeleteModelOutput {
        return delete_model.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon SageMaker AI model bias job definition.
    pub fn deleteModelBiasJobDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_model_bias_job_definition.DeleteModelBiasJobDefinitionInput, options: delete_model_bias_job_definition.Options) !delete_model_bias_job_definition.DeleteModelBiasJobDefinitionOutput {
        return delete_model_bias_job_definition.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon SageMaker Model Card.
    pub fn deleteModelCard(self: *Self, allocator: std.mem.Allocator, input: delete_model_card.DeleteModelCardInput, options: delete_model_card.Options) !delete_model_card.DeleteModelCardOutput {
        return delete_model_card.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon SageMaker AI model explainability job definition.
    pub fn deleteModelExplainabilityJobDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_model_explainability_job_definition.DeleteModelExplainabilityJobDefinitionInput, options: delete_model_explainability_job_definition.Options) !delete_model_explainability_job_definition.DeleteModelExplainabilityJobDefinitionOutput {
        return delete_model_explainability_job_definition.execute(self, allocator, input, options);
    }

    /// Deletes a model package.
    ///
    /// A model package is used to create SageMaker models or list on Amazon Web
    /// Services Marketplace. Buyers can subscribe to model packages listed on
    /// Amazon Web Services Marketplace to create models in SageMaker.
    pub fn deleteModelPackage(self: *Self, allocator: std.mem.Allocator, input: delete_model_package.DeleteModelPackageInput, options: delete_model_package.Options) !delete_model_package.DeleteModelPackageOutput {
        return delete_model_package.execute(self, allocator, input, options);
    }

    /// Deletes the specified model group.
    pub fn deleteModelPackageGroup(self: *Self, allocator: std.mem.Allocator, input: delete_model_package_group.DeleteModelPackageGroupInput, options: delete_model_package_group.Options) !delete_model_package_group.DeleteModelPackageGroupOutput {
        return delete_model_package_group.execute(self, allocator, input, options);
    }

    /// Deletes a model group resource policy.
    pub fn deleteModelPackageGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_model_package_group_policy.DeleteModelPackageGroupPolicyInput, options: delete_model_package_group_policy.Options) !delete_model_package_group_policy.DeleteModelPackageGroupPolicyOutput {
        return delete_model_package_group_policy.execute(self, allocator, input, options);
    }

    /// Deletes the secified model quality monitoring job definition.
    pub fn deleteModelQualityJobDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_model_quality_job_definition.DeleteModelQualityJobDefinitionInput, options: delete_model_quality_job_definition.Options) !delete_model_quality_job_definition.DeleteModelQualityJobDefinitionOutput {
        return delete_model_quality_job_definition.execute(self, allocator, input, options);
    }

    /// Deletes a monitoring schedule. Also stops the schedule had not already been
    /// stopped. This does not delete the job execution history of the monitoring
    /// schedule.
    pub fn deleteMonitoringSchedule(self: *Self, allocator: std.mem.Allocator, input: delete_monitoring_schedule.DeleteMonitoringScheduleInput, options: delete_monitoring_schedule.Options) !delete_monitoring_schedule.DeleteMonitoringScheduleOutput {
        return delete_monitoring_schedule.execute(self, allocator, input, options);
    }

    /// Deletes an SageMaker AI notebook instance. Before you can delete a notebook
    /// instance, you must call the `StopNotebookInstance` API.
    ///
    /// When you delete a notebook instance, you lose all of your data. SageMaker AI
    /// removes the ML compute instance, and deletes the ML storage volume and the
    /// network interface associated with the notebook instance.
    pub fn deleteNotebookInstance(self: *Self, allocator: std.mem.Allocator, input: delete_notebook_instance.DeleteNotebookInstanceInput, options: delete_notebook_instance.Options) !delete_notebook_instance.DeleteNotebookInstanceOutput {
        return delete_notebook_instance.execute(self, allocator, input, options);
    }

    /// Deletes a notebook instance lifecycle configuration.
    pub fn deleteNotebookInstanceLifecycleConfig(self: *Self, allocator: std.mem.Allocator, input: delete_notebook_instance_lifecycle_config.DeleteNotebookInstanceLifecycleConfigInput, options: delete_notebook_instance_lifecycle_config.Options) !delete_notebook_instance_lifecycle_config.DeleteNotebookInstanceLifecycleConfigOutput {
        return delete_notebook_instance_lifecycle_config.execute(self, allocator, input, options);
    }

    /// Deletes an optimization job.
    pub fn deleteOptimizationJob(self: *Self, allocator: std.mem.Allocator, input: delete_optimization_job.DeleteOptimizationJobInput, options: delete_optimization_job.Options) !delete_optimization_job.DeleteOptimizationJobOutput {
        return delete_optimization_job.execute(self, allocator, input, options);
    }

    /// Deletes a SageMaker Partner AI App.
    pub fn deletePartnerApp(self: *Self, allocator: std.mem.Allocator, input: delete_partner_app.DeletePartnerAppInput, options: delete_partner_app.Options) !delete_partner_app.DeletePartnerAppOutput {
        return delete_partner_app.execute(self, allocator, input, options);
    }

    /// Deletes a pipeline if there are no running instances of the pipeline. To
    /// delete a pipeline, you must stop all running instances of the pipeline using
    /// the `StopPipelineExecution` API. When you delete a pipeline, all instances
    /// of the pipeline are deleted.
    pub fn deletePipeline(self: *Self, allocator: std.mem.Allocator, input: delete_pipeline.DeletePipelineInput, options: delete_pipeline.Options) !delete_pipeline.DeletePipelineOutput {
        return delete_pipeline.execute(self, allocator, input, options);
    }

    /// Deletes a processing job. After Amazon SageMaker deletes a processing job,
    /// all of the metadata for the processing job is lost. You can delete only
    /// processing jobs that are in a terminal state (`Stopped`, `Failed`, or
    /// `Completed`). You cannot delete a job that is in the `InProgress` or
    /// `Stopping` state. After deleting the job, you can reuse its name to create
    /// another processing job.
    pub fn deleteProcessingJob(self: *Self, allocator: std.mem.Allocator, input: delete_processing_job.DeleteProcessingJobInput, options: delete_processing_job.Options) !delete_processing_job.DeleteProcessingJobOutput {
        return delete_processing_job.execute(self, allocator, input, options);
    }

    /// Delete the specified project.
    pub fn deleteProject(self: *Self, allocator: std.mem.Allocator, input: delete_project.DeleteProjectInput, options: delete_project.Options) !delete_project.DeleteProjectOutput {
        return delete_project.execute(self, allocator, input, options);
    }

    /// Used to delete a space.
    pub fn deleteSpace(self: *Self, allocator: std.mem.Allocator, input: delete_space.DeleteSpaceInput, options: delete_space.Options) !delete_space.DeleteSpaceOutput {
        return delete_space.execute(self, allocator, input, options);
    }

    /// Deletes the Amazon SageMaker AI Studio Lifecycle Configuration. In order to
    /// delete the Lifecycle Configuration, there must be no running apps using the
    /// Lifecycle Configuration. You must also remove the Lifecycle Configuration
    /// from UserSettings in all Domains and UserProfiles.
    pub fn deleteStudioLifecycleConfig(self: *Self, allocator: std.mem.Allocator, input: delete_studio_lifecycle_config.DeleteStudioLifecycleConfigInput, options: delete_studio_lifecycle_config.Options) !delete_studio_lifecycle_config.DeleteStudioLifecycleConfigOutput {
        return delete_studio_lifecycle_config.execute(self, allocator, input, options);
    }

    /// Deletes the specified tags from an SageMaker resource.
    ///
    /// To list a resource's tags, use the `ListTags` API.
    ///
    /// When you call this API to delete tags from a hyperparameter tuning job, the
    /// deleted tags are not removed from training jobs that the hyperparameter
    /// tuning job launched before you called this API.
    ///
    /// When you call this API to delete tags from a SageMaker Domain or User
    /// Profile, the deleted tags are not removed from Apps that the SageMaker
    /// Domain or User Profile launched before you called this API.
    pub fn deleteTags(self: *Self, allocator: std.mem.Allocator, input: delete_tags.DeleteTagsInput, options: delete_tags.Options) !delete_tags.DeleteTagsOutput {
        return delete_tags.execute(self, allocator, input, options);
    }

    /// Deletes a training job. After SageMaker deletes a training job, all of the
    /// metadata for the training job is lost. You can delete only training jobs
    /// that are in a terminal state (`Stopped`, `Failed`, or `Completed`) and don't
    /// retain an `Available` [managed warm
    /// pool](https://docs.aws.amazon.com/sagemaker/latest/dg/train-warm-pools.html). You cannot delete a job that is in the `InProgress` or `Stopping` state. After deleting the job, you can reuse its name to create another training job.
    pub fn deleteTrainingJob(self: *Self, allocator: std.mem.Allocator, input: delete_training_job.DeleteTrainingJobInput, options: delete_training_job.Options) !delete_training_job.DeleteTrainingJobOutput {
        return delete_training_job.execute(self, allocator, input, options);
    }

    /// Deletes the specified trial. All trial components that make up the trial
    /// must be deleted first. Use the
    /// [DescribeTrialComponent](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeTrialComponent.html) API to get the list of trial components.
    pub fn deleteTrial(self: *Self, allocator: std.mem.Allocator, input: delete_trial.DeleteTrialInput, options: delete_trial.Options) !delete_trial.DeleteTrialOutput {
        return delete_trial.execute(self, allocator, input, options);
    }

    /// Deletes the specified trial component. A trial component must be
    /// disassociated from all trials before the trial component can be deleted. To
    /// disassociate a trial component from a trial, call the
    /// [DisassociateTrialComponent](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DisassociateTrialComponent.html) API.
    pub fn deleteTrialComponent(self: *Self, allocator: std.mem.Allocator, input: delete_trial_component.DeleteTrialComponentInput, options: delete_trial_component.Options) !delete_trial_component.DeleteTrialComponentOutput {
        return delete_trial_component.execute(self, allocator, input, options);
    }

    /// Deletes a user profile. When a user profile is deleted, the user loses
    /// access to their EFS volume, including data, notebooks, and other artifacts.
    pub fn deleteUserProfile(self: *Self, allocator: std.mem.Allocator, input: delete_user_profile.DeleteUserProfileInput, options: delete_user_profile.Options) !delete_user_profile.DeleteUserProfileOutput {
        return delete_user_profile.execute(self, allocator, input, options);
    }

    /// Use this operation to delete a workforce.
    ///
    /// If you want to create a new workforce in an Amazon Web Services Region where
    /// a workforce already exists, use this operation to delete the existing
    /// workforce and then use
    /// [CreateWorkforce](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateWorkforce.html) to create a new workforce.
    ///
    /// If a private workforce contains one or more work teams, you must use the
    /// [DeleteWorkteam](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DeleteWorkteam.html) operation to delete all work teams before you delete the workforce. If you try to delete a workforce that contains one or more work teams, you will receive a `ResourceInUse` error.
    pub fn deleteWorkforce(self: *Self, allocator: std.mem.Allocator, input: delete_workforce.DeleteWorkforceInput, options: delete_workforce.Options) !delete_workforce.DeleteWorkforceOutput {
        return delete_workforce.execute(self, allocator, input, options);
    }

    /// Deletes an existing work team. This operation can't be undone.
    pub fn deleteWorkteam(self: *Self, allocator: std.mem.Allocator, input: delete_workteam.DeleteWorkteamInput, options: delete_workteam.Options) !delete_workteam.DeleteWorkteamOutput {
        return delete_workteam.execute(self, allocator, input, options);
    }

    /// Deregisters the specified devices. After you deregister a device, you will
    /// need to re-register the devices.
    pub fn deregisterDevices(self: *Self, allocator: std.mem.Allocator, input: deregister_devices.DeregisterDevicesInput, options: deregister_devices.Options) !deregister_devices.DeregisterDevicesOutput {
        return deregister_devices.execute(self, allocator, input, options);
    }

    /// Describes an action.
    pub fn describeAction(self: *Self, allocator: std.mem.Allocator, input: describe_action.DescribeActionInput, options: describe_action.Options) !describe_action.DescribeActionOutput {
        return describe_action.execute(self, allocator, input, options);
    }

    /// Returns a description of the specified algorithm that is in your account.
    pub fn describeAlgorithm(self: *Self, allocator: std.mem.Allocator, input: describe_algorithm.DescribeAlgorithmInput, options: describe_algorithm.Options) !describe_algorithm.DescribeAlgorithmOutput {
        return describe_algorithm.execute(self, allocator, input, options);
    }

    /// Describes the app.
    pub fn describeApp(self: *Self, allocator: std.mem.Allocator, input: describe_app.DescribeAppInput, options: describe_app.Options) !describe_app.DescribeAppOutput {
        return describe_app.execute(self, allocator, input, options);
    }

    /// Describes an AppImageConfig.
    pub fn describeAppImageConfig(self: *Self, allocator: std.mem.Allocator, input: describe_app_image_config.DescribeAppImageConfigInput, options: describe_app_image_config.Options) !describe_app_image_config.DescribeAppImageConfigOutput {
        return describe_app_image_config.execute(self, allocator, input, options);
    }

    /// Describes an artifact.
    pub fn describeArtifact(self: *Self, allocator: std.mem.Allocator, input: describe_artifact.DescribeArtifactInput, options: describe_artifact.Options) !describe_artifact.DescribeArtifactOutput {
        return describe_artifact.execute(self, allocator, input, options);
    }

    /// Returns information about an AutoML job created by calling
    /// [CreateAutoMLJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateAutoMLJob.html).
    ///
    /// AutoML jobs created by calling
    /// [CreateAutoMLJobV2](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateAutoMLJobV2.html) cannot be described by `DescribeAutoMLJob`.
    pub fn describeAutoMlJob(self: *Self, allocator: std.mem.Allocator, input: describe_auto_ml_job.DescribeAutoMLJobInput, options: describe_auto_ml_job.Options) !describe_auto_ml_job.DescribeAutoMLJobOutput {
        return describe_auto_ml_job.execute(self, allocator, input, options);
    }

    /// Returns information about an AutoML job created by calling
    /// [CreateAutoMLJobV2](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateAutoMLJobV2.html) or [CreateAutoMLJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateAutoMLJob.html).
    pub fn describeAutoMlJobV2(self: *Self, allocator: std.mem.Allocator, input: describe_auto_ml_job_v2.DescribeAutoMLJobV2Input, options: describe_auto_ml_job_v2.Options) !describe_auto_ml_job_v2.DescribeAutoMLJobV2Output {
        return describe_auto_ml_job_v2.execute(self, allocator, input, options);
    }

    /// Retrieves information of a SageMaker HyperPod cluster.
    pub fn describeCluster(self: *Self, allocator: std.mem.Allocator, input: describe_cluster.DescribeClusterInput, options: describe_cluster.Options) !describe_cluster.DescribeClusterOutput {
        return describe_cluster.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific event for a given HyperPod
    /// cluster. This functionality is only supported when the
    /// `NodeProvisioningMode` is set to `Continuous`.
    pub fn describeClusterEvent(self: *Self, allocator: std.mem.Allocator, input: describe_cluster_event.DescribeClusterEventInput, options: describe_cluster_event.Options) !describe_cluster_event.DescribeClusterEventOutput {
        return describe_cluster_event.execute(self, allocator, input, options);
    }

    /// Retrieves information of a node (also called a *instance* interchangeably)
    /// of a SageMaker HyperPod cluster.
    pub fn describeClusterNode(self: *Self, allocator: std.mem.Allocator, input: describe_cluster_node.DescribeClusterNodeInput, options: describe_cluster_node.Options) !describe_cluster_node.DescribeClusterNodeOutput {
        return describe_cluster_node.execute(self, allocator, input, options);
    }

    /// Description of the cluster policy. This policy is used for task
    /// prioritization and fair-share allocation. This helps prioritize critical
    /// workloads and distributes idle compute across entities.
    pub fn describeClusterSchedulerConfig(self: *Self, allocator: std.mem.Allocator, input: describe_cluster_scheduler_config.DescribeClusterSchedulerConfigInput, options: describe_cluster_scheduler_config.Options) !describe_cluster_scheduler_config.DescribeClusterSchedulerConfigOutput {
        return describe_cluster_scheduler_config.execute(self, allocator, input, options);
    }

    /// Gets details about the specified Git repository.
    pub fn describeCodeRepository(self: *Self, allocator: std.mem.Allocator, input: describe_code_repository.DescribeCodeRepositoryInput, options: describe_code_repository.Options) !describe_code_repository.DescribeCodeRepositoryOutput {
        return describe_code_repository.execute(self, allocator, input, options);
    }

    /// Returns information about a model compilation job.
    ///
    /// To create a model compilation job, use
    /// [CreateCompilationJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateCompilationJob.html). To get information about multiple model compilation jobs, use [ListCompilationJobs](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ListCompilationJobs.html).
    pub fn describeCompilationJob(self: *Self, allocator: std.mem.Allocator, input: describe_compilation_job.DescribeCompilationJobInput, options: describe_compilation_job.Options) !describe_compilation_job.DescribeCompilationJobOutput {
        return describe_compilation_job.execute(self, allocator, input, options);
    }

    /// Description of the compute allocation definition.
    pub fn describeComputeQuota(self: *Self, allocator: std.mem.Allocator, input: describe_compute_quota.DescribeComputeQuotaInput, options: describe_compute_quota.Options) !describe_compute_quota.DescribeComputeQuotaOutput {
        return describe_compute_quota.execute(self, allocator, input, options);
    }

    /// Describes a context.
    pub fn describeContext(self: *Self, allocator: std.mem.Allocator, input: describe_context.DescribeContextInput, options: describe_context.Options) !describe_context.DescribeContextOutput {
        return describe_context.execute(self, allocator, input, options);
    }

    /// Gets the details of a data quality monitoring job definition.
    pub fn describeDataQualityJobDefinition(self: *Self, allocator: std.mem.Allocator, input: describe_data_quality_job_definition.DescribeDataQualityJobDefinitionInput, options: describe_data_quality_job_definition.Options) !describe_data_quality_job_definition.DescribeDataQualityJobDefinitionOutput {
        return describe_data_quality_job_definition.execute(self, allocator, input, options);
    }

    /// Describes the device.
    pub fn describeDevice(self: *Self, allocator: std.mem.Allocator, input: describe_device.DescribeDeviceInput, options: describe_device.Options) !describe_device.DescribeDeviceOutput {
        return describe_device.execute(self, allocator, input, options);
    }

    /// A description of the fleet the device belongs to.
    pub fn describeDeviceFleet(self: *Self, allocator: std.mem.Allocator, input: describe_device_fleet.DescribeDeviceFleetInput, options: describe_device_fleet.Options) !describe_device_fleet.DescribeDeviceFleetOutput {
        return describe_device_fleet.execute(self, allocator, input, options);
    }

    /// The description of the domain.
    pub fn describeDomain(self: *Self, allocator: std.mem.Allocator, input: describe_domain.DescribeDomainInput, options: describe_domain.Options) !describe_domain.DescribeDomainOutput {
        return describe_domain.execute(self, allocator, input, options);
    }

    /// Describes an edge deployment plan with deployment status per stage.
    pub fn describeEdgeDeploymentPlan(self: *Self, allocator: std.mem.Allocator, input: describe_edge_deployment_plan.DescribeEdgeDeploymentPlanInput, options: describe_edge_deployment_plan.Options) !describe_edge_deployment_plan.DescribeEdgeDeploymentPlanOutput {
        return describe_edge_deployment_plan.execute(self, allocator, input, options);
    }

    /// A description of edge packaging jobs.
    pub fn describeEdgePackagingJob(self: *Self, allocator: std.mem.Allocator, input: describe_edge_packaging_job.DescribeEdgePackagingJobInput, options: describe_edge_packaging_job.Options) !describe_edge_packaging_job.DescribeEdgePackagingJobOutput {
        return describe_edge_packaging_job.execute(self, allocator, input, options);
    }

    /// Returns the description of an endpoint.
    pub fn describeEndpoint(self: *Self, allocator: std.mem.Allocator, input: describe_endpoint.DescribeEndpointInput, options: describe_endpoint.Options) !describe_endpoint.DescribeEndpointOutput {
        return describe_endpoint.execute(self, allocator, input, options);
    }

    /// Returns the description of an endpoint configuration created using the
    /// `CreateEndpointConfig` API.
    pub fn describeEndpointConfig(self: *Self, allocator: std.mem.Allocator, input: describe_endpoint_config.DescribeEndpointConfigInput, options: describe_endpoint_config.Options) !describe_endpoint_config.DescribeEndpointConfigOutput {
        return describe_endpoint_config.execute(self, allocator, input, options);
    }

    /// Provides a list of an experiment's properties.
    pub fn describeExperiment(self: *Self, allocator: std.mem.Allocator, input: describe_experiment.DescribeExperimentInput, options: describe_experiment.Options) !describe_experiment.DescribeExperimentOutput {
        return describe_experiment.execute(self, allocator, input, options);
    }

    /// Use this operation to describe a `FeatureGroup`. The response includes
    /// information on the creation time, `FeatureGroup` name, the unique identifier
    /// for each `FeatureGroup`, and more.
    pub fn describeFeatureGroup(self: *Self, allocator: std.mem.Allocator, input: describe_feature_group.DescribeFeatureGroupInput, options: describe_feature_group.Options) !describe_feature_group.DescribeFeatureGroupOutput {
        return describe_feature_group.execute(self, allocator, input, options);
    }

    /// Shows the metadata for a feature within a feature group.
    pub fn describeFeatureMetadata(self: *Self, allocator: std.mem.Allocator, input: describe_feature_metadata.DescribeFeatureMetadataInput, options: describe_feature_metadata.Options) !describe_feature_metadata.DescribeFeatureMetadataOutput {
        return describe_feature_metadata.execute(self, allocator, input, options);
    }

    /// Returns information about the specified flow definition.
    pub fn describeFlowDefinition(self: *Self, allocator: std.mem.Allocator, input: describe_flow_definition.DescribeFlowDefinitionInput, options: describe_flow_definition.Options) !describe_flow_definition.DescribeFlowDefinitionOutput {
        return describe_flow_definition.execute(self, allocator, input, options);
    }

    /// Describes a hub.
    pub fn describeHub(self: *Self, allocator: std.mem.Allocator, input: describe_hub.DescribeHubInput, options: describe_hub.Options) !describe_hub.DescribeHubOutput {
        return describe_hub.execute(self, allocator, input, options);
    }

    /// Describe the content of a hub.
    pub fn describeHubContent(self: *Self, allocator: std.mem.Allocator, input: describe_hub_content.DescribeHubContentInput, options: describe_hub_content.Options) !describe_hub_content.DescribeHubContentOutput {
        return describe_hub_content.execute(self, allocator, input, options);
    }

    /// Returns information about the requested human task user interface (worker
    /// task template).
    pub fn describeHumanTaskUi(self: *Self, allocator: std.mem.Allocator, input: describe_human_task_ui.DescribeHumanTaskUiInput, options: describe_human_task_ui.Options) !describe_human_task_ui.DescribeHumanTaskUiOutput {
        return describe_human_task_ui.execute(self, allocator, input, options);
    }

    /// Returns a description of a hyperparameter tuning job, depending on the
    /// fields selected. These fields can include the name, Amazon Resource Name
    /// (ARN), job status of your tuning job and more.
    pub fn describeHyperParameterTuningJob(self: *Self, allocator: std.mem.Allocator, input: describe_hyper_parameter_tuning_job.DescribeHyperParameterTuningJobInput, options: describe_hyper_parameter_tuning_job.Options) !describe_hyper_parameter_tuning_job.DescribeHyperParameterTuningJobOutput {
        return describe_hyper_parameter_tuning_job.execute(self, allocator, input, options);
    }

    /// Describes a SageMaker AI image.
    pub fn describeImage(self: *Self, allocator: std.mem.Allocator, input: describe_image.DescribeImageInput, options: describe_image.Options) !describe_image.DescribeImageOutput {
        return describe_image.execute(self, allocator, input, options);
    }

    /// Describes a version of a SageMaker AI image.
    pub fn describeImageVersion(self: *Self, allocator: std.mem.Allocator, input: describe_image_version.DescribeImageVersionInput, options: describe_image_version.Options) !describe_image_version.DescribeImageVersionOutput {
        return describe_image_version.execute(self, allocator, input, options);
    }

    /// Returns information about an inference component.
    pub fn describeInferenceComponent(self: *Self, allocator: std.mem.Allocator, input: describe_inference_component.DescribeInferenceComponentInput, options: describe_inference_component.Options) !describe_inference_component.DescribeInferenceComponentOutput {
        return describe_inference_component.execute(self, allocator, input, options);
    }

    /// Returns details about an inference experiment.
    pub fn describeInferenceExperiment(self: *Self, allocator: std.mem.Allocator, input: describe_inference_experiment.DescribeInferenceExperimentInput, options: describe_inference_experiment.Options) !describe_inference_experiment.DescribeInferenceExperimentOutput {
        return describe_inference_experiment.execute(self, allocator, input, options);
    }

    /// Provides the results of the Inference Recommender job. One or more
    /// recommendation jobs are returned.
    pub fn describeInferenceRecommendationsJob(self: *Self, allocator: std.mem.Allocator, input: describe_inference_recommendations_job.DescribeInferenceRecommendationsJobInput, options: describe_inference_recommendations_job.Options) !describe_inference_recommendations_job.DescribeInferenceRecommendationsJobOutput {
        return describe_inference_recommendations_job.execute(self, allocator, input, options);
    }

    /// Gets information about a labeling job.
    pub fn describeLabelingJob(self: *Self, allocator: std.mem.Allocator, input: describe_labeling_job.DescribeLabelingJobInput, options: describe_labeling_job.Options) !describe_labeling_job.DescribeLabelingJobOutput {
        return describe_labeling_job.execute(self, allocator, input, options);
    }

    /// Provides a list of properties for the requested lineage group. For more
    /// information, see [ Cross-Account Lineage Tracking
    /// ](https://docs.aws.amazon.com/sagemaker/latest/dg/xaccount-lineage-tracking.html) in the *Amazon SageMaker Developer Guide*.
    pub fn describeLineageGroup(self: *Self, allocator: std.mem.Allocator, input: describe_lineage_group.DescribeLineageGroupInput, options: describe_lineage_group.Options) !describe_lineage_group.DescribeLineageGroupOutput {
        return describe_lineage_group.execute(self, allocator, input, options);
    }

    /// Returns information about an MLflow App.
    pub fn describeMlflowApp(self: *Self, allocator: std.mem.Allocator, input: describe_mlflow_app.DescribeMlflowAppInput, options: describe_mlflow_app.Options) !describe_mlflow_app.DescribeMlflowAppOutput {
        return describe_mlflow_app.execute(self, allocator, input, options);
    }

    /// Returns information about an MLflow Tracking Server.
    pub fn describeMlflowTrackingServer(self: *Self, allocator: std.mem.Allocator, input: describe_mlflow_tracking_server.DescribeMlflowTrackingServerInput, options: describe_mlflow_tracking_server.Options) !describe_mlflow_tracking_server.DescribeMlflowTrackingServerOutput {
        return describe_mlflow_tracking_server.execute(self, allocator, input, options);
    }

    /// Describes a model that you created using the `CreateModel` API.
    pub fn describeModel(self: *Self, allocator: std.mem.Allocator, input: describe_model.DescribeModelInput, options: describe_model.Options) !describe_model.DescribeModelOutput {
        return describe_model.execute(self, allocator, input, options);
    }

    /// Returns a description of a model bias job definition.
    pub fn describeModelBiasJobDefinition(self: *Self, allocator: std.mem.Allocator, input: describe_model_bias_job_definition.DescribeModelBiasJobDefinitionInput, options: describe_model_bias_job_definition.Options) !describe_model_bias_job_definition.DescribeModelBiasJobDefinitionOutput {
        return describe_model_bias_job_definition.execute(self, allocator, input, options);
    }

    /// Describes the content, creation time, and security configuration of an
    /// Amazon SageMaker Model Card.
    pub fn describeModelCard(self: *Self, allocator: std.mem.Allocator, input: describe_model_card.DescribeModelCardInput, options: describe_model_card.Options) !describe_model_card.DescribeModelCardOutput {
        return describe_model_card.execute(self, allocator, input, options);
    }

    /// Describes an Amazon SageMaker Model Card export job.
    pub fn describeModelCardExportJob(self: *Self, allocator: std.mem.Allocator, input: describe_model_card_export_job.DescribeModelCardExportJobInput, options: describe_model_card_export_job.Options) !describe_model_card_export_job.DescribeModelCardExportJobOutput {
        return describe_model_card_export_job.execute(self, allocator, input, options);
    }

    /// Returns a description of a model explainability job definition.
    pub fn describeModelExplainabilityJobDefinition(self: *Self, allocator: std.mem.Allocator, input: describe_model_explainability_job_definition.DescribeModelExplainabilityJobDefinitionInput, options: describe_model_explainability_job_definition.Options) !describe_model_explainability_job_definition.DescribeModelExplainabilityJobDefinitionOutput {
        return describe_model_explainability_job_definition.execute(self, allocator, input, options);
    }

    /// Returns a description of the specified model package, which is used to
    /// create SageMaker models or list them on Amazon Web Services Marketplace.
    ///
    /// If you provided a KMS Key ID when you created your model package, you will
    /// see the [KMS
    /// Decrypt](https://docs.aws.amazon.com/kms/latest/APIReference/API_Decrypt.html) API call in your CloudTrail logs when you use this API.
    ///
    /// To create models in SageMaker, buyers can subscribe to model packages listed
    /// on Amazon Web Services Marketplace.
    pub fn describeModelPackage(self: *Self, allocator: std.mem.Allocator, input: describe_model_package.DescribeModelPackageInput, options: describe_model_package.Options) !describe_model_package.DescribeModelPackageOutput {
        return describe_model_package.execute(self, allocator, input, options);
    }

    /// Gets a description for the specified model group.
    pub fn describeModelPackageGroup(self: *Self, allocator: std.mem.Allocator, input: describe_model_package_group.DescribeModelPackageGroupInput, options: describe_model_package_group.Options) !describe_model_package_group.DescribeModelPackageGroupOutput {
        return describe_model_package_group.execute(self, allocator, input, options);
    }

    /// Returns a description of a model quality job definition.
    pub fn describeModelQualityJobDefinition(self: *Self, allocator: std.mem.Allocator, input: describe_model_quality_job_definition.DescribeModelQualityJobDefinitionInput, options: describe_model_quality_job_definition.Options) !describe_model_quality_job_definition.DescribeModelQualityJobDefinitionOutput {
        return describe_model_quality_job_definition.execute(self, allocator, input, options);
    }

    /// Describes the schedule for a monitoring job.
    pub fn describeMonitoringSchedule(self: *Self, allocator: std.mem.Allocator, input: describe_monitoring_schedule.DescribeMonitoringScheduleInput, options: describe_monitoring_schedule.Options) !describe_monitoring_schedule.DescribeMonitoringScheduleOutput {
        return describe_monitoring_schedule.execute(self, allocator, input, options);
    }

    /// Returns information about a notebook instance.
    pub fn describeNotebookInstance(self: *Self, allocator: std.mem.Allocator, input: describe_notebook_instance.DescribeNotebookInstanceInput, options: describe_notebook_instance.Options) !describe_notebook_instance.DescribeNotebookInstanceOutput {
        return describe_notebook_instance.execute(self, allocator, input, options);
    }

    /// Returns a description of a notebook instance lifecycle configuration.
    ///
    /// For information about notebook instance lifestyle configurations, see [Step
    /// 2.1: (Optional) Customize a Notebook
    /// Instance](https://docs.aws.amazon.com/sagemaker/latest/dg/notebook-lifecycle-config.html).
    pub fn describeNotebookInstanceLifecycleConfig(self: *Self, allocator: std.mem.Allocator, input: describe_notebook_instance_lifecycle_config.DescribeNotebookInstanceLifecycleConfigInput, options: describe_notebook_instance_lifecycle_config.Options) !describe_notebook_instance_lifecycle_config.DescribeNotebookInstanceLifecycleConfigOutput {
        return describe_notebook_instance_lifecycle_config.execute(self, allocator, input, options);
    }

    /// Provides the properties of the specified optimization job.
    pub fn describeOptimizationJob(self: *Self, allocator: std.mem.Allocator, input: describe_optimization_job.DescribeOptimizationJobInput, options: describe_optimization_job.Options) !describe_optimization_job.DescribeOptimizationJobOutput {
        return describe_optimization_job.execute(self, allocator, input, options);
    }

    /// Gets information about a SageMaker Partner AI App.
    pub fn describePartnerApp(self: *Self, allocator: std.mem.Allocator, input: describe_partner_app.DescribePartnerAppInput, options: describe_partner_app.Options) !describe_partner_app.DescribePartnerAppOutput {
        return describe_partner_app.execute(self, allocator, input, options);
    }

    /// Describes the details of a pipeline.
    pub fn describePipeline(self: *Self, allocator: std.mem.Allocator, input: describe_pipeline.DescribePipelineInput, options: describe_pipeline.Options) !describe_pipeline.DescribePipelineOutput {
        return describe_pipeline.execute(self, allocator, input, options);
    }

    /// Describes the details of an execution's pipeline definition.
    pub fn describePipelineDefinitionForExecution(self: *Self, allocator: std.mem.Allocator, input: describe_pipeline_definition_for_execution.DescribePipelineDefinitionForExecutionInput, options: describe_pipeline_definition_for_execution.Options) !describe_pipeline_definition_for_execution.DescribePipelineDefinitionForExecutionOutput {
        return describe_pipeline_definition_for_execution.execute(self, allocator, input, options);
    }

    /// Describes the details of a pipeline execution.
    pub fn describePipelineExecution(self: *Self, allocator: std.mem.Allocator, input: describe_pipeline_execution.DescribePipelineExecutionInput, options: describe_pipeline_execution.Options) !describe_pipeline_execution.DescribePipelineExecutionOutput {
        return describe_pipeline_execution.execute(self, allocator, input, options);
    }

    /// Returns a description of a processing job.
    pub fn describeProcessingJob(self: *Self, allocator: std.mem.Allocator, input: describe_processing_job.DescribeProcessingJobInput, options: describe_processing_job.Options) !describe_processing_job.DescribeProcessingJobOutput {
        return describe_processing_job.execute(self, allocator, input, options);
    }

    /// Describes the details of a project.
    pub fn describeProject(self: *Self, allocator: std.mem.Allocator, input: describe_project.DescribeProjectInput, options: describe_project.Options) !describe_project.DescribeProjectOutput {
        return describe_project.execute(self, allocator, input, options);
    }

    /// Retrieves details about a reserved capacity.
    pub fn describeReservedCapacity(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_capacity.DescribeReservedCapacityInput, options: describe_reserved_capacity.Options) !describe_reserved_capacity.DescribeReservedCapacityOutput {
        return describe_reserved_capacity.execute(self, allocator, input, options);
    }

    /// Describes the space.
    pub fn describeSpace(self: *Self, allocator: std.mem.Allocator, input: describe_space.DescribeSpaceInput, options: describe_space.Options) !describe_space.DescribeSpaceOutput {
        return describe_space.execute(self, allocator, input, options);
    }

    /// Describes the Amazon SageMaker AI Studio Lifecycle Configuration.
    pub fn describeStudioLifecycleConfig(self: *Self, allocator: std.mem.Allocator, input: describe_studio_lifecycle_config.DescribeStudioLifecycleConfigInput, options: describe_studio_lifecycle_config.Options) !describe_studio_lifecycle_config.DescribeStudioLifecycleConfigOutput {
        return describe_studio_lifecycle_config.execute(self, allocator, input, options);
    }

    /// Gets information about a work team provided by a vendor. It returns details
    /// about the subscription with a vendor in the Amazon Web Services Marketplace.
    pub fn describeSubscribedWorkteam(self: *Self, allocator: std.mem.Allocator, input: describe_subscribed_workteam.DescribeSubscribedWorkteamInput, options: describe_subscribed_workteam.Options) !describe_subscribed_workteam.DescribeSubscribedWorkteamOutput {
        return describe_subscribed_workteam.execute(self, allocator, input, options);
    }

    /// Returns information about a training job.
    ///
    /// Some of the attributes below only appear if the training job successfully
    /// starts. If the training job fails, `TrainingJobStatus` is `Failed` and,
    /// depending on the `FailureReason`, attributes like `TrainingStartTime`,
    /// `TrainingTimeInSeconds`, `TrainingEndTime`, and `BillableTimeInSeconds` may
    /// not be present in the response.
    pub fn describeTrainingJob(self: *Self, allocator: std.mem.Allocator, input: describe_training_job.DescribeTrainingJobInput, options: describe_training_job.Options) !describe_training_job.DescribeTrainingJobOutput {
        return describe_training_job.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific training plan.
    pub fn describeTrainingPlan(self: *Self, allocator: std.mem.Allocator, input: describe_training_plan.DescribeTrainingPlanInput, options: describe_training_plan.Options) !describe_training_plan.DescribeTrainingPlanOutput {
        return describe_training_plan.execute(self, allocator, input, options);
    }

    /// Returns information about a transform job.
    pub fn describeTransformJob(self: *Self, allocator: std.mem.Allocator, input: describe_transform_job.DescribeTransformJobInput, options: describe_transform_job.Options) !describe_transform_job.DescribeTransformJobOutput {
        return describe_transform_job.execute(self, allocator, input, options);
    }

    /// Provides a list of a trial's properties.
    pub fn describeTrial(self: *Self, allocator: std.mem.Allocator, input: describe_trial.DescribeTrialInput, options: describe_trial.Options) !describe_trial.DescribeTrialOutput {
        return describe_trial.execute(self, allocator, input, options);
    }

    /// Provides a list of a trials component's properties.
    pub fn describeTrialComponent(self: *Self, allocator: std.mem.Allocator, input: describe_trial_component.DescribeTrialComponentInput, options: describe_trial_component.Options) !describe_trial_component.DescribeTrialComponentOutput {
        return describe_trial_component.execute(self, allocator, input, options);
    }

    /// Describes a user profile. For more information, see `CreateUserProfile`.
    pub fn describeUserProfile(self: *Self, allocator: std.mem.Allocator, input: describe_user_profile.DescribeUserProfileInput, options: describe_user_profile.Options) !describe_user_profile.DescribeUserProfileOutput {
        return describe_user_profile.execute(self, allocator, input, options);
    }

    /// Lists private workforce information, including workforce name, Amazon
    /// Resource Name (ARN), and, if applicable, allowed IP address ranges
    /// ([CIDRs](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html)). Allowable IP address ranges are the IP addresses that workers can use to access tasks.
    ///
    /// This operation applies only to private workforces.
    pub fn describeWorkforce(self: *Self, allocator: std.mem.Allocator, input: describe_workforce.DescribeWorkforceInput, options: describe_workforce.Options) !describe_workforce.DescribeWorkforceOutput {
        return describe_workforce.execute(self, allocator, input, options);
    }

    /// Gets information about a specific work team. You can see information such as
    /// the creation date, the last updated date, membership information, and the
    /// work team's Amazon Resource Name (ARN).
    pub fn describeWorkteam(self: *Self, allocator: std.mem.Allocator, input: describe_workteam.DescribeWorkteamInput, options: describe_workteam.Options) !describe_workteam.DescribeWorkteamOutput {
        return describe_workteam.execute(self, allocator, input, options);
    }

    /// Detaches your Amazon Elastic Block Store (Amazon EBS) volume from a node in
    /// your EKS orchestrated SageMaker HyperPod cluster.
    ///
    /// This API works with the Amazon Elastic Block Store (Amazon EBS) Container
    /// Storage Interface (CSI) driver to manage the lifecycle of persistent storage
    /// in your HyperPod EKS clusters.
    pub fn detachClusterNodeVolume(self: *Self, allocator: std.mem.Allocator, input: detach_cluster_node_volume.DetachClusterNodeVolumeInput, options: detach_cluster_node_volume.Options) !detach_cluster_node_volume.DetachClusterNodeVolumeOutput {
        return detach_cluster_node_volume.execute(self, allocator, input, options);
    }

    /// Disables using Service Catalog in SageMaker. Service Catalog is used to
    /// create SageMaker projects.
    pub fn disableSagemakerServicecatalogPortfolio(self: *Self, allocator: std.mem.Allocator, input: disable_sagemaker_servicecatalog_portfolio.DisableSagemakerServicecatalogPortfolioInput, options: disable_sagemaker_servicecatalog_portfolio.Options) !disable_sagemaker_servicecatalog_portfolio.DisableSagemakerServicecatalogPortfolioOutput {
        return disable_sagemaker_servicecatalog_portfolio.execute(self, allocator, input, options);
    }

    /// Disassociates a trial component from a trial. This doesn't effect other
    /// trials the component is associated with. Before you can delete a component,
    /// you must disassociate the component from all trials it is associated with.
    /// To associate a trial component with a trial, call the
    /// [AssociateTrialComponent](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AssociateTrialComponent.html) API.
    ///
    /// To get a list of the trials a component is associated with, use the
    /// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API. Specify `ExperimentTrialComponent` for the `Resource` parameter. The list appears in the response under `Results.TrialComponent.Parents`.
    pub fn disassociateTrialComponent(self: *Self, allocator: std.mem.Allocator, input: disassociate_trial_component.DisassociateTrialComponentInput, options: disassociate_trial_component.Options) !disassociate_trial_component.DisassociateTrialComponentOutput {
        return disassociate_trial_component.execute(self, allocator, input, options);
    }

    /// Enables using Service Catalog in SageMaker. Service Catalog is used to
    /// create SageMaker projects.
    pub fn enableSagemakerServicecatalogPortfolio(self: *Self, allocator: std.mem.Allocator, input: enable_sagemaker_servicecatalog_portfolio.EnableSagemakerServicecatalogPortfolioInput, options: enable_sagemaker_servicecatalog_portfolio.Options) !enable_sagemaker_servicecatalog_portfolio.EnableSagemakerServicecatalogPortfolioOutput {
        return enable_sagemaker_servicecatalog_portfolio.execute(self, allocator, input, options);
    }

    /// Describes a fleet.
    pub fn getDeviceFleetReport(self: *Self, allocator: std.mem.Allocator, input: get_device_fleet_report.GetDeviceFleetReportInput, options: get_device_fleet_report.Options) !get_device_fleet_report.GetDeviceFleetReportOutput {
        return get_device_fleet_report.execute(self, allocator, input, options);
    }

    /// The resource policy for the lineage group.
    pub fn getLineageGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: get_lineage_group_policy.GetLineageGroupPolicyInput, options: get_lineage_group_policy.Options) !get_lineage_group_policy.GetLineageGroupPolicyOutput {
        return get_lineage_group_policy.execute(self, allocator, input, options);
    }

    /// Gets a resource policy that manages access for a model group. For
    /// information about resource policies, see [Identity-based policies and
    /// resource-based
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_identity-vs-resource.html) in the *Amazon Web Services Identity and Access Management User Guide.*.
    pub fn getModelPackageGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: get_model_package_group_policy.GetModelPackageGroupPolicyInput, options: get_model_package_group_policy.Options) !get_model_package_group_policy.GetModelPackageGroupPolicyOutput {
        return get_model_package_group_policy.execute(self, allocator, input, options);
    }

    /// Gets the status of Service Catalog in SageMaker. Service Catalog is used to
    /// create SageMaker projects.
    pub fn getSagemakerServicecatalogPortfolioStatus(self: *Self, allocator: std.mem.Allocator, input: get_sagemaker_servicecatalog_portfolio_status.GetSagemakerServicecatalogPortfolioStatusInput, options: get_sagemaker_servicecatalog_portfolio_status.Options) !get_sagemaker_servicecatalog_portfolio_status.GetSagemakerServicecatalogPortfolioStatusOutput {
        return get_sagemaker_servicecatalog_portfolio_status.execute(self, allocator, input, options);
    }

    /// Starts an Amazon SageMaker Inference Recommender autoscaling recommendation
    /// job. Returns recommendations for autoscaling policies that you can apply to
    /// your SageMaker endpoint.
    pub fn getScalingConfigurationRecommendation(self: *Self, allocator: std.mem.Allocator, input: get_scaling_configuration_recommendation.GetScalingConfigurationRecommendationInput, options: get_scaling_configuration_recommendation.Options) !get_scaling_configuration_recommendation.GetScalingConfigurationRecommendationOutput {
        return get_scaling_configuration_recommendation.execute(self, allocator, input, options);
    }

    /// An auto-complete API for the search functionality in the SageMaker console.
    /// It returns suggestions of possible matches for the property name to use in
    /// `Search` queries. Provides suggestions for `HyperParameters`, `Tags`, and
    /// `Metrics`.
    pub fn getSearchSuggestions(self: *Self, allocator: std.mem.Allocator, input: get_search_suggestions.GetSearchSuggestionsInput, options: get_search_suggestions.Options) !get_search_suggestions.GetSearchSuggestionsOutput {
        return get_search_suggestions.execute(self, allocator, input, options);
    }

    /// Import hub content.
    pub fn importHubContent(self: *Self, allocator: std.mem.Allocator, input: import_hub_content.ImportHubContentInput, options: import_hub_content.Options) !import_hub_content.ImportHubContentOutput {
        return import_hub_content.execute(self, allocator, input, options);
    }

    /// Lists the actions in your account and their properties.
    pub fn listActions(self: *Self, allocator: std.mem.Allocator, input: list_actions.ListActionsInput, options: list_actions.Options) !list_actions.ListActionsOutput {
        return list_actions.execute(self, allocator, input, options);
    }

    /// Lists the machine learning algorithms that have been created.
    pub fn listAlgorithms(self: *Self, allocator: std.mem.Allocator, input: list_algorithms.ListAlgorithmsInput, options: list_algorithms.Options) !list_algorithms.ListAlgorithmsOutput {
        return list_algorithms.execute(self, allocator, input, options);
    }

    /// Lists the aliases of a specified image or image version.
    pub fn listAliases(self: *Self, allocator: std.mem.Allocator, input: list_aliases.ListAliasesInput, options: list_aliases.Options) !list_aliases.ListAliasesOutput {
        return list_aliases.execute(self, allocator, input, options);
    }

    /// Lists the AppImageConfigs in your account and their properties. The list can
    /// be filtered by creation time or modified time, and whether the
    /// AppImageConfig name contains a specified string.
    pub fn listAppImageConfigs(self: *Self, allocator: std.mem.Allocator, input: list_app_image_configs.ListAppImageConfigsInput, options: list_app_image_configs.Options) !list_app_image_configs.ListAppImageConfigsOutput {
        return list_app_image_configs.execute(self, allocator, input, options);
    }

    /// Lists apps.
    pub fn listApps(self: *Self, allocator: std.mem.Allocator, input: list_apps.ListAppsInput, options: list_apps.Options) !list_apps.ListAppsOutput {
        return list_apps.execute(self, allocator, input, options);
    }

    /// Lists the artifacts in your account and their properties.
    pub fn listArtifacts(self: *Self, allocator: std.mem.Allocator, input: list_artifacts.ListArtifactsInput, options: list_artifacts.Options) !list_artifacts.ListArtifactsOutput {
        return list_artifacts.execute(self, allocator, input, options);
    }

    /// Lists the associations in your account and their properties.
    pub fn listAssociations(self: *Self, allocator: std.mem.Allocator, input: list_associations.ListAssociationsInput, options: list_associations.Options) !list_associations.ListAssociationsOutput {
        return list_associations.execute(self, allocator, input, options);
    }

    /// Request a list of jobs.
    pub fn listAutoMlJobs(self: *Self, allocator: std.mem.Allocator, input: list_auto_ml_jobs.ListAutoMLJobsInput, options: list_auto_ml_jobs.Options) !list_auto_ml_jobs.ListAutoMLJobsOutput {
        return list_auto_ml_jobs.execute(self, allocator, input, options);
    }

    /// List the candidates created for the job.
    pub fn listCandidatesForAutoMlJob(self: *Self, allocator: std.mem.Allocator, input: list_candidates_for_auto_ml_job.ListCandidatesForAutoMLJobInput, options: list_candidates_for_auto_ml_job.Options) !list_candidates_for_auto_ml_job.ListCandidatesForAutoMLJobOutput {
        return list_candidates_for_auto_ml_job.execute(self, allocator, input, options);
    }

    /// Retrieves a list of event summaries for a specified HyperPod cluster. The
    /// operation supports filtering, sorting, and pagination of results. This
    /// functionality is only supported when the `NodeProvisioningMode` is set to
    /// `Continuous`.
    pub fn listClusterEvents(self: *Self, allocator: std.mem.Allocator, input: list_cluster_events.ListClusterEventsInput, options: list_cluster_events.Options) !list_cluster_events.ListClusterEventsOutput {
        return list_cluster_events.execute(self, allocator, input, options);
    }

    /// Retrieves the list of instances (also called *nodes* interchangeably) in a
    /// SageMaker HyperPod cluster.
    pub fn listClusterNodes(self: *Self, allocator: std.mem.Allocator, input: list_cluster_nodes.ListClusterNodesInput, options: list_cluster_nodes.Options) !list_cluster_nodes.ListClusterNodesOutput {
        return list_cluster_nodes.execute(self, allocator, input, options);
    }

    /// List the cluster policy configurations.
    pub fn listClusterSchedulerConfigs(self: *Self, allocator: std.mem.Allocator, input: list_cluster_scheduler_configs.ListClusterSchedulerConfigsInput, options: list_cluster_scheduler_configs.Options) !list_cluster_scheduler_configs.ListClusterSchedulerConfigsOutput {
        return list_cluster_scheduler_configs.execute(self, allocator, input, options);
    }

    /// Retrieves the list of SageMaker HyperPod clusters.
    pub fn listClusters(self: *Self, allocator: std.mem.Allocator, input: list_clusters.ListClustersInput, options: list_clusters.Options) !list_clusters.ListClustersOutput {
        return list_clusters.execute(self, allocator, input, options);
    }

    /// Gets a list of the Git repositories in your account.
    pub fn listCodeRepositories(self: *Self, allocator: std.mem.Allocator, input: list_code_repositories.ListCodeRepositoriesInput, options: list_code_repositories.Options) !list_code_repositories.ListCodeRepositoriesOutput {
        return list_code_repositories.execute(self, allocator, input, options);
    }

    /// Lists model compilation jobs that satisfy various filters.
    ///
    /// To create a model compilation job, use
    /// [CreateCompilationJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateCompilationJob.html). To get information about a particular model compilation job you have created, use [DescribeCompilationJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeCompilationJob.html).
    pub fn listCompilationJobs(self: *Self, allocator: std.mem.Allocator, input: list_compilation_jobs.ListCompilationJobsInput, options: list_compilation_jobs.Options) !list_compilation_jobs.ListCompilationJobsOutput {
        return list_compilation_jobs.execute(self, allocator, input, options);
    }

    /// List the resource allocation definitions.
    pub fn listComputeQuotas(self: *Self, allocator: std.mem.Allocator, input: list_compute_quotas.ListComputeQuotasInput, options: list_compute_quotas.Options) !list_compute_quotas.ListComputeQuotasOutput {
        return list_compute_quotas.execute(self, allocator, input, options);
    }

    /// Lists the contexts in your account and their properties.
    pub fn listContexts(self: *Self, allocator: std.mem.Allocator, input: list_contexts.ListContextsInput, options: list_contexts.Options) !list_contexts.ListContextsOutput {
        return list_contexts.execute(self, allocator, input, options);
    }

    /// Lists the data quality job definitions in your account.
    pub fn listDataQualityJobDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_data_quality_job_definitions.ListDataQualityJobDefinitionsInput, options: list_data_quality_job_definitions.Options) !list_data_quality_job_definitions.ListDataQualityJobDefinitionsOutput {
        return list_data_quality_job_definitions.execute(self, allocator, input, options);
    }

    /// Returns a list of devices in the fleet.
    pub fn listDeviceFleets(self: *Self, allocator: std.mem.Allocator, input: list_device_fleets.ListDeviceFleetsInput, options: list_device_fleets.Options) !list_device_fleets.ListDeviceFleetsOutput {
        return list_device_fleets.execute(self, allocator, input, options);
    }

    /// A list of devices.
    pub fn listDevices(self: *Self, allocator: std.mem.Allocator, input: list_devices.ListDevicesInput, options: list_devices.Options) !list_devices.ListDevicesOutput {
        return list_devices.execute(self, allocator, input, options);
    }

    /// Lists the domains.
    pub fn listDomains(self: *Self, allocator: std.mem.Allocator, input: list_domains.ListDomainsInput, options: list_domains.Options) !list_domains.ListDomainsOutput {
        return list_domains.execute(self, allocator, input, options);
    }

    /// Lists all edge deployment plans.
    pub fn listEdgeDeploymentPlans(self: *Self, allocator: std.mem.Allocator, input: list_edge_deployment_plans.ListEdgeDeploymentPlansInput, options: list_edge_deployment_plans.Options) !list_edge_deployment_plans.ListEdgeDeploymentPlansOutput {
        return list_edge_deployment_plans.execute(self, allocator, input, options);
    }

    /// Returns a list of edge packaging jobs.
    pub fn listEdgePackagingJobs(self: *Self, allocator: std.mem.Allocator, input: list_edge_packaging_jobs.ListEdgePackagingJobsInput, options: list_edge_packaging_jobs.Options) !list_edge_packaging_jobs.ListEdgePackagingJobsOutput {
        return list_edge_packaging_jobs.execute(self, allocator, input, options);
    }

    /// Lists endpoint configurations.
    pub fn listEndpointConfigs(self: *Self, allocator: std.mem.Allocator, input: list_endpoint_configs.ListEndpointConfigsInput, options: list_endpoint_configs.Options) !list_endpoint_configs.ListEndpointConfigsOutput {
        return list_endpoint_configs.execute(self, allocator, input, options);
    }

    /// Lists endpoints.
    pub fn listEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_endpoints.ListEndpointsInput, options: list_endpoints.Options) !list_endpoints.ListEndpointsOutput {
        return list_endpoints.execute(self, allocator, input, options);
    }

    /// Lists all the experiments in your account. The list can be filtered to show
    /// only experiments that were created in a specific time range. The list can be
    /// sorted by experiment name or creation time.
    pub fn listExperiments(self: *Self, allocator: std.mem.Allocator, input: list_experiments.ListExperimentsInput, options: list_experiments.Options) !list_experiments.ListExperimentsOutput {
        return list_experiments.execute(self, allocator, input, options);
    }

    /// List `FeatureGroup`s based on given filter and order.
    pub fn listFeatureGroups(self: *Self, allocator: std.mem.Allocator, input: list_feature_groups.ListFeatureGroupsInput, options: list_feature_groups.Options) !list_feature_groups.ListFeatureGroupsOutput {
        return list_feature_groups.execute(self, allocator, input, options);
    }

    /// Returns information about the flow definitions in your account.
    pub fn listFlowDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_flow_definitions.ListFlowDefinitionsInput, options: list_flow_definitions.Options) !list_flow_definitions.ListFlowDefinitionsOutput {
        return list_flow_definitions.execute(self, allocator, input, options);
    }

    /// List hub content versions.
    pub fn listHubContentVersions(self: *Self, allocator: std.mem.Allocator, input: list_hub_content_versions.ListHubContentVersionsInput, options: list_hub_content_versions.Options) !list_hub_content_versions.ListHubContentVersionsOutput {
        return list_hub_content_versions.execute(self, allocator, input, options);
    }

    /// List the contents of a hub.
    pub fn listHubContents(self: *Self, allocator: std.mem.Allocator, input: list_hub_contents.ListHubContentsInput, options: list_hub_contents.Options) !list_hub_contents.ListHubContentsOutput {
        return list_hub_contents.execute(self, allocator, input, options);
    }

    /// List all existing hubs.
    pub fn listHubs(self: *Self, allocator: std.mem.Allocator, input: list_hubs.ListHubsInput, options: list_hubs.Options) !list_hubs.ListHubsOutput {
        return list_hubs.execute(self, allocator, input, options);
    }

    /// Returns information about the human task user interfaces in your account.
    pub fn listHumanTaskUis(self: *Self, allocator: std.mem.Allocator, input: list_human_task_uis.ListHumanTaskUisInput, options: list_human_task_uis.Options) !list_human_task_uis.ListHumanTaskUisOutput {
        return list_human_task_uis.execute(self, allocator, input, options);
    }

    /// Gets a list of
    /// [HyperParameterTuningJobSummary](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTuningJobSummary.html) objects that describe the hyperparameter tuning jobs launched in your account.
    pub fn listHyperParameterTuningJobs(self: *Self, allocator: std.mem.Allocator, input: list_hyper_parameter_tuning_jobs.ListHyperParameterTuningJobsInput, options: list_hyper_parameter_tuning_jobs.Options) !list_hyper_parameter_tuning_jobs.ListHyperParameterTuningJobsOutput {
        return list_hyper_parameter_tuning_jobs.execute(self, allocator, input, options);
    }

    /// Lists the versions of a specified image and their properties. The list can
    /// be filtered by creation time or modified time.
    pub fn listImageVersions(self: *Self, allocator: std.mem.Allocator, input: list_image_versions.ListImageVersionsInput, options: list_image_versions.Options) !list_image_versions.ListImageVersionsOutput {
        return list_image_versions.execute(self, allocator, input, options);
    }

    /// Lists the images in your account and their properties. The list can be
    /// filtered by creation time or modified time, and whether the image name
    /// contains a specified string.
    pub fn listImages(self: *Self, allocator: std.mem.Allocator, input: list_images.ListImagesInput, options: list_images.Options) !list_images.ListImagesOutput {
        return list_images.execute(self, allocator, input, options);
    }

    /// Lists the inference components in your account and their properties.
    pub fn listInferenceComponents(self: *Self, allocator: std.mem.Allocator, input: list_inference_components.ListInferenceComponentsInput, options: list_inference_components.Options) !list_inference_components.ListInferenceComponentsOutput {
        return list_inference_components.execute(self, allocator, input, options);
    }

    /// Returns the list of all inference experiments.
    pub fn listInferenceExperiments(self: *Self, allocator: std.mem.Allocator, input: list_inference_experiments.ListInferenceExperimentsInput, options: list_inference_experiments.Options) !list_inference_experiments.ListInferenceExperimentsOutput {
        return list_inference_experiments.execute(self, allocator, input, options);
    }

    /// Returns a list of the subtasks for an Inference Recommender job.
    ///
    /// The supported subtasks are benchmarks, which evaluate the performance of
    /// your model on different instance types.
    pub fn listInferenceRecommendationsJobSteps(self: *Self, allocator: std.mem.Allocator, input: list_inference_recommendations_job_steps.ListInferenceRecommendationsJobStepsInput, options: list_inference_recommendations_job_steps.Options) !list_inference_recommendations_job_steps.ListInferenceRecommendationsJobStepsOutput {
        return list_inference_recommendations_job_steps.execute(self, allocator, input, options);
    }

    /// Lists recommendation jobs that satisfy various filters.
    pub fn listInferenceRecommendationsJobs(self: *Self, allocator: std.mem.Allocator, input: list_inference_recommendations_jobs.ListInferenceRecommendationsJobsInput, options: list_inference_recommendations_jobs.Options) !list_inference_recommendations_jobs.ListInferenceRecommendationsJobsOutput {
        return list_inference_recommendations_jobs.execute(self, allocator, input, options);
    }

    /// Gets a list of labeling jobs.
    pub fn listLabelingJobs(self: *Self, allocator: std.mem.Allocator, input: list_labeling_jobs.ListLabelingJobsInput, options: list_labeling_jobs.Options) !list_labeling_jobs.ListLabelingJobsOutput {
        return list_labeling_jobs.execute(self, allocator, input, options);
    }

    /// Gets a list of labeling jobs assigned to a specified work team.
    pub fn listLabelingJobsForWorkteam(self: *Self, allocator: std.mem.Allocator, input: list_labeling_jobs_for_workteam.ListLabelingJobsForWorkteamInput, options: list_labeling_jobs_for_workteam.Options) !list_labeling_jobs_for_workteam.ListLabelingJobsForWorkteamOutput {
        return list_labeling_jobs_for_workteam.execute(self, allocator, input, options);
    }

    /// A list of lineage groups shared with your Amazon Web Services account. For
    /// more information, see [ Cross-Account Lineage Tracking
    /// ](https://docs.aws.amazon.com/sagemaker/latest/dg/xaccount-lineage-tracking.html) in the *Amazon SageMaker Developer Guide*.
    pub fn listLineageGroups(self: *Self, allocator: std.mem.Allocator, input: list_lineage_groups.ListLineageGroupsInput, options: list_lineage_groups.Options) !list_lineage_groups.ListLineageGroupsOutput {
        return list_lineage_groups.execute(self, allocator, input, options);
    }

    /// Lists all MLflow Apps
    pub fn listMlflowApps(self: *Self, allocator: std.mem.Allocator, input: list_mlflow_apps.ListMlflowAppsInput, options: list_mlflow_apps.Options) !list_mlflow_apps.ListMlflowAppsOutput {
        return list_mlflow_apps.execute(self, allocator, input, options);
    }

    /// Lists all MLflow Tracking Servers.
    pub fn listMlflowTrackingServers(self: *Self, allocator: std.mem.Allocator, input: list_mlflow_tracking_servers.ListMlflowTrackingServersInput, options: list_mlflow_tracking_servers.Options) !list_mlflow_tracking_servers.ListMlflowTrackingServersOutput {
        return list_mlflow_tracking_servers.execute(self, allocator, input, options);
    }

    /// Lists model bias jobs definitions that satisfy various filters.
    pub fn listModelBiasJobDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_model_bias_job_definitions.ListModelBiasJobDefinitionsInput, options: list_model_bias_job_definitions.Options) !list_model_bias_job_definitions.ListModelBiasJobDefinitionsOutput {
        return list_model_bias_job_definitions.execute(self, allocator, input, options);
    }

    /// List the export jobs for the Amazon SageMaker Model Card.
    pub fn listModelCardExportJobs(self: *Self, allocator: std.mem.Allocator, input: list_model_card_export_jobs.ListModelCardExportJobsInput, options: list_model_card_export_jobs.Options) !list_model_card_export_jobs.ListModelCardExportJobsOutput {
        return list_model_card_export_jobs.execute(self, allocator, input, options);
    }

    /// List existing versions of an Amazon SageMaker Model Card.
    pub fn listModelCardVersions(self: *Self, allocator: std.mem.Allocator, input: list_model_card_versions.ListModelCardVersionsInput, options: list_model_card_versions.Options) !list_model_card_versions.ListModelCardVersionsOutput {
        return list_model_card_versions.execute(self, allocator, input, options);
    }

    /// List existing model cards.
    pub fn listModelCards(self: *Self, allocator: std.mem.Allocator, input: list_model_cards.ListModelCardsInput, options: list_model_cards.Options) !list_model_cards.ListModelCardsOutput {
        return list_model_cards.execute(self, allocator, input, options);
    }

    /// Lists model explainability job definitions that satisfy various filters.
    pub fn listModelExplainabilityJobDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_model_explainability_job_definitions.ListModelExplainabilityJobDefinitionsInput, options: list_model_explainability_job_definitions.Options) !list_model_explainability_job_definitions.ListModelExplainabilityJobDefinitionsOutput {
        return list_model_explainability_job_definitions.execute(self, allocator, input, options);
    }

    /// Lists the domain, framework, task, and model name of standard machine
    /// learning models found in common model zoos.
    pub fn listModelMetadata(self: *Self, allocator: std.mem.Allocator, input: list_model_metadata.ListModelMetadataInput, options: list_model_metadata.Options) !list_model_metadata.ListModelMetadataOutput {
        return list_model_metadata.execute(self, allocator, input, options);
    }

    /// Gets a list of the model groups in your Amazon Web Services account.
    pub fn listModelPackageGroups(self: *Self, allocator: std.mem.Allocator, input: list_model_package_groups.ListModelPackageGroupsInput, options: list_model_package_groups.Options) !list_model_package_groups.ListModelPackageGroupsOutput {
        return list_model_package_groups.execute(self, allocator, input, options);
    }

    /// Lists the model packages that have been created.
    pub fn listModelPackages(self: *Self, allocator: std.mem.Allocator, input: list_model_packages.ListModelPackagesInput, options: list_model_packages.Options) !list_model_packages.ListModelPackagesOutput {
        return list_model_packages.execute(self, allocator, input, options);
    }

    /// Gets a list of model quality monitoring job definitions in your account.
    pub fn listModelQualityJobDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_model_quality_job_definitions.ListModelQualityJobDefinitionsInput, options: list_model_quality_job_definitions.Options) !list_model_quality_job_definitions.ListModelQualityJobDefinitionsOutput {
        return list_model_quality_job_definitions.execute(self, allocator, input, options);
    }

    /// Lists models created with the `CreateModel` API.
    pub fn listModels(self: *Self, allocator: std.mem.Allocator, input: list_models.ListModelsInput, options: list_models.Options) !list_models.ListModelsOutput {
        return list_models.execute(self, allocator, input, options);
    }

    /// Gets a list of past alerts in a model monitoring schedule.
    pub fn listMonitoringAlertHistory(self: *Self, allocator: std.mem.Allocator, input: list_monitoring_alert_history.ListMonitoringAlertHistoryInput, options: list_monitoring_alert_history.Options) !list_monitoring_alert_history.ListMonitoringAlertHistoryOutput {
        return list_monitoring_alert_history.execute(self, allocator, input, options);
    }

    /// Gets the alerts for a single monitoring schedule.
    pub fn listMonitoringAlerts(self: *Self, allocator: std.mem.Allocator, input: list_monitoring_alerts.ListMonitoringAlertsInput, options: list_monitoring_alerts.Options) !list_monitoring_alerts.ListMonitoringAlertsOutput {
        return list_monitoring_alerts.execute(self, allocator, input, options);
    }

    /// Returns list of all monitoring job executions.
    pub fn listMonitoringExecutions(self: *Self, allocator: std.mem.Allocator, input: list_monitoring_executions.ListMonitoringExecutionsInput, options: list_monitoring_executions.Options) !list_monitoring_executions.ListMonitoringExecutionsOutput {
        return list_monitoring_executions.execute(self, allocator, input, options);
    }

    /// Returns list of all monitoring schedules.
    pub fn listMonitoringSchedules(self: *Self, allocator: std.mem.Allocator, input: list_monitoring_schedules.ListMonitoringSchedulesInput, options: list_monitoring_schedules.Options) !list_monitoring_schedules.ListMonitoringSchedulesOutput {
        return list_monitoring_schedules.execute(self, allocator, input, options);
    }

    /// Lists notebook instance lifestyle configurations created with the
    /// [CreateNotebookInstanceLifecycleConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateNotebookInstanceLifecycleConfig.html) API.
    pub fn listNotebookInstanceLifecycleConfigs(self: *Self, allocator: std.mem.Allocator, input: list_notebook_instance_lifecycle_configs.ListNotebookInstanceLifecycleConfigsInput, options: list_notebook_instance_lifecycle_configs.Options) !list_notebook_instance_lifecycle_configs.ListNotebookInstanceLifecycleConfigsOutput {
        return list_notebook_instance_lifecycle_configs.execute(self, allocator, input, options);
    }

    /// Returns a list of the SageMaker AI notebook instances in the requester's
    /// account in an Amazon Web Services Region.
    pub fn listNotebookInstances(self: *Self, allocator: std.mem.Allocator, input: list_notebook_instances.ListNotebookInstancesInput, options: list_notebook_instances.Options) !list_notebook_instances.ListNotebookInstancesOutput {
        return list_notebook_instances.execute(self, allocator, input, options);
    }

    /// Lists the optimization jobs in your account and their properties.
    pub fn listOptimizationJobs(self: *Self, allocator: std.mem.Allocator, input: list_optimization_jobs.ListOptimizationJobsInput, options: list_optimization_jobs.Options) !list_optimization_jobs.ListOptimizationJobsOutput {
        return list_optimization_jobs.execute(self, allocator, input, options);
    }

    /// Lists all of the SageMaker Partner AI Apps in an account.
    pub fn listPartnerApps(self: *Self, allocator: std.mem.Allocator, input: list_partner_apps.ListPartnerAppsInput, options: list_partner_apps.Options) !list_partner_apps.ListPartnerAppsOutput {
        return list_partner_apps.execute(self, allocator, input, options);
    }

    /// Gets a list of `PipeLineExecutionStep` objects.
    pub fn listPipelineExecutionSteps(self: *Self, allocator: std.mem.Allocator, input: list_pipeline_execution_steps.ListPipelineExecutionStepsInput, options: list_pipeline_execution_steps.Options) !list_pipeline_execution_steps.ListPipelineExecutionStepsOutput {
        return list_pipeline_execution_steps.execute(self, allocator, input, options);
    }

    /// Gets a list of the pipeline executions.
    pub fn listPipelineExecutions(self: *Self, allocator: std.mem.Allocator, input: list_pipeline_executions.ListPipelineExecutionsInput, options: list_pipeline_executions.Options) !list_pipeline_executions.ListPipelineExecutionsOutput {
        return list_pipeline_executions.execute(self, allocator, input, options);
    }

    /// Gets a list of parameters for a pipeline execution.
    pub fn listPipelineParametersForExecution(self: *Self, allocator: std.mem.Allocator, input: list_pipeline_parameters_for_execution.ListPipelineParametersForExecutionInput, options: list_pipeline_parameters_for_execution.Options) !list_pipeline_parameters_for_execution.ListPipelineParametersForExecutionOutput {
        return list_pipeline_parameters_for_execution.execute(self, allocator, input, options);
    }

    /// Gets a list of all versions of the pipeline.
    pub fn listPipelineVersions(self: *Self, allocator: std.mem.Allocator, input: list_pipeline_versions.ListPipelineVersionsInput, options: list_pipeline_versions.Options) !list_pipeline_versions.ListPipelineVersionsOutput {
        return list_pipeline_versions.execute(self, allocator, input, options);
    }

    /// Gets a list of pipelines.
    pub fn listPipelines(self: *Self, allocator: std.mem.Allocator, input: list_pipelines.ListPipelinesInput, options: list_pipelines.Options) !list_pipelines.ListPipelinesOutput {
        return list_pipelines.execute(self, allocator, input, options);
    }

    /// Lists processing jobs that satisfy various filters.
    pub fn listProcessingJobs(self: *Self, allocator: std.mem.Allocator, input: list_processing_jobs.ListProcessingJobsInput, options: list_processing_jobs.Options) !list_processing_jobs.ListProcessingJobsOutput {
        return list_processing_jobs.execute(self, allocator, input, options);
    }

    /// Gets a list of the projects in an Amazon Web Services account.
    pub fn listProjects(self: *Self, allocator: std.mem.Allocator, input: list_projects.ListProjectsInput, options: list_projects.Options) !list_projects.ListProjectsOutput {
        return list_projects.execute(self, allocator, input, options);
    }

    /// Lists Amazon SageMaker Catalogs based on given filters and orders. The
    /// maximum number of `ResourceCatalog`s viewable is 1000.
    pub fn listResourceCatalogs(self: *Self, allocator: std.mem.Allocator, input: list_resource_catalogs.ListResourceCatalogsInput, options: list_resource_catalogs.Options) !list_resource_catalogs.ListResourceCatalogsOutput {
        return list_resource_catalogs.execute(self, allocator, input, options);
    }

    /// Lists spaces.
    pub fn listSpaces(self: *Self, allocator: std.mem.Allocator, input: list_spaces.ListSpacesInput, options: list_spaces.Options) !list_spaces.ListSpacesOutput {
        return list_spaces.execute(self, allocator, input, options);
    }

    /// Lists devices allocated to the stage, containing detailed device information
    /// and deployment status.
    pub fn listStageDevices(self: *Self, allocator: std.mem.Allocator, input: list_stage_devices.ListStageDevicesInput, options: list_stage_devices.Options) !list_stage_devices.ListStageDevicesOutput {
        return list_stage_devices.execute(self, allocator, input, options);
    }

    /// Lists the Amazon SageMaker AI Studio Lifecycle Configurations in your Amazon
    /// Web Services Account.
    pub fn listStudioLifecycleConfigs(self: *Self, allocator: std.mem.Allocator, input: list_studio_lifecycle_configs.ListStudioLifecycleConfigsInput, options: list_studio_lifecycle_configs.Options) !list_studio_lifecycle_configs.ListStudioLifecycleConfigsOutput {
        return list_studio_lifecycle_configs.execute(self, allocator, input, options);
    }

    /// Gets a list of the work teams that you are subscribed to in the Amazon Web
    /// Services Marketplace. The list may be empty if no work team satisfies the
    /// filter specified in the `NameContains` parameter.
    pub fn listSubscribedWorkteams(self: *Self, allocator: std.mem.Allocator, input: list_subscribed_workteams.ListSubscribedWorkteamsInput, options: list_subscribed_workteams.Options) !list_subscribed_workteams.ListSubscribedWorkteamsOutput {
        return list_subscribed_workteams.execute(self, allocator, input, options);
    }

    /// Returns the tags for the specified SageMaker resource.
    pub fn listTags(self: *Self, allocator: std.mem.Allocator, input: list_tags.ListTagsInput, options: list_tags.Options) !list_tags.ListTagsOutput {
        return list_tags.execute(self, allocator, input, options);
    }

    /// Lists training jobs.
    ///
    /// When `StatusEquals` and `MaxResults` are set at the same time, the
    /// `MaxResults` number of training jobs are first retrieved ignoring the
    /// `StatusEquals` parameter and then they are filtered by the `StatusEquals`
    /// parameter, which is returned as a response.
    ///
    /// For example, if `ListTrainingJobs` is invoked with the following parameters:
    ///
    /// `{ ... MaxResults: 100, StatusEquals: InProgress ... }`
    ///
    /// First, 100 trainings jobs with any status, including those other than
    /// `InProgress`, are selected (sorted according to the creation time, from the
    /// most current to the oldest). Next, those with a status of `InProgress` are
    /// returned.
    ///
    /// You can quickly test the API using the following Amazon Web Services CLI
    /// code.
    ///
    /// `aws sagemaker list-training-jobs --max-results 100 --status-equals
    /// InProgress`
    pub fn listTrainingJobs(self: *Self, allocator: std.mem.Allocator, input: list_training_jobs.ListTrainingJobsInput, options: list_training_jobs.Options) !list_training_jobs.ListTrainingJobsOutput {
        return list_training_jobs.execute(self, allocator, input, options);
    }

    /// Gets a list of
    /// [TrainingJobSummary](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_TrainingJobSummary.html) objects that describe the training jobs that a hyperparameter tuning job launched.
    pub fn listTrainingJobsForHyperParameterTuningJob(self: *Self, allocator: std.mem.Allocator, input: list_training_jobs_for_hyper_parameter_tuning_job.ListTrainingJobsForHyperParameterTuningJobInput, options: list_training_jobs_for_hyper_parameter_tuning_job.Options) !list_training_jobs_for_hyper_parameter_tuning_job.ListTrainingJobsForHyperParameterTuningJobOutput {
        return list_training_jobs_for_hyper_parameter_tuning_job.execute(self, allocator, input, options);
    }

    /// Retrieves a list of training plans for the current account.
    pub fn listTrainingPlans(self: *Self, allocator: std.mem.Allocator, input: list_training_plans.ListTrainingPlansInput, options: list_training_plans.Options) !list_training_plans.ListTrainingPlansOutput {
        return list_training_plans.execute(self, allocator, input, options);
    }

    /// Lists transform jobs.
    pub fn listTransformJobs(self: *Self, allocator: std.mem.Allocator, input: list_transform_jobs.ListTransformJobsInput, options: list_transform_jobs.Options) !list_transform_jobs.ListTransformJobsOutput {
        return list_transform_jobs.execute(self, allocator, input, options);
    }

    /// Lists the trial components in your account. You can sort the list by trial
    /// component name or creation time. You can filter the list to show only
    /// components that were created in a specific time range. You can also filter
    /// on one of the following:
    ///
    /// * `ExperimentName`
    /// * `SourceArn`
    /// * `TrialName`
    pub fn listTrialComponents(self: *Self, allocator: std.mem.Allocator, input: list_trial_components.ListTrialComponentsInput, options: list_trial_components.Options) !list_trial_components.ListTrialComponentsOutput {
        return list_trial_components.execute(self, allocator, input, options);
    }

    /// Lists the trials in your account. Specify an experiment name to limit the
    /// list to the trials that are part of that experiment. Specify a trial
    /// component name to limit the list to the trials that associated with that
    /// trial component. The list can be filtered to show only trials that were
    /// created in a specific time range. The list can be sorted by trial name or
    /// creation time.
    pub fn listTrials(self: *Self, allocator: std.mem.Allocator, input: list_trials.ListTrialsInput, options: list_trials.Options) !list_trials.ListTrialsOutput {
        return list_trials.execute(self, allocator, input, options);
    }

    /// Lists all UltraServers that are part of a specified reserved capacity.
    pub fn listUltraServersByReservedCapacity(self: *Self, allocator: std.mem.Allocator, input: list_ultra_servers_by_reserved_capacity.ListUltraServersByReservedCapacityInput, options: list_ultra_servers_by_reserved_capacity.Options) !list_ultra_servers_by_reserved_capacity.ListUltraServersByReservedCapacityOutput {
        return list_ultra_servers_by_reserved_capacity.execute(self, allocator, input, options);
    }

    /// Lists user profiles.
    pub fn listUserProfiles(self: *Self, allocator: std.mem.Allocator, input: list_user_profiles.ListUserProfilesInput, options: list_user_profiles.Options) !list_user_profiles.ListUserProfilesOutput {
        return list_user_profiles.execute(self, allocator, input, options);
    }

    /// Use this operation to list all private and vendor workforces in an Amazon
    /// Web Services Region. Note that you can only have one private workforce per
    /// Amazon Web Services Region.
    pub fn listWorkforces(self: *Self, allocator: std.mem.Allocator, input: list_workforces.ListWorkforcesInput, options: list_workforces.Options) !list_workforces.ListWorkforcesOutput {
        return list_workforces.execute(self, allocator, input, options);
    }

    /// Gets a list of private work teams that you have defined in a region. The
    /// list may be empty if no work team satisfies the filter specified in the
    /// `NameContains` parameter.
    pub fn listWorkteams(self: *Self, allocator: std.mem.Allocator, input: list_workteams.ListWorkteamsInput, options: list_workteams.Options) !list_workteams.ListWorkteamsOutput {
        return list_workteams.execute(self, allocator, input, options);
    }

    /// Adds a resouce policy to control access to a model group. For information
    /// about resoure policies, see [Identity-based policies and resource-based
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_identity-vs-resource.html) in the *Amazon Web Services Identity and Access Management User Guide.*.
    pub fn putModelPackageGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: put_model_package_group_policy.PutModelPackageGroupPolicyInput, options: put_model_package_group_policy.Options) !put_model_package_group_policy.PutModelPackageGroupPolicyOutput {
        return put_model_package_group_policy.execute(self, allocator, input, options);
    }

    /// Use this action to inspect your lineage and discover relationships between
    /// entities. For more information, see [ Querying Lineage
    /// Entities](https://docs.aws.amazon.com/sagemaker/latest/dg/querying-lineage-entities.html) in the *Amazon SageMaker Developer Guide*.
    pub fn queryLineage(self: *Self, allocator: std.mem.Allocator, input: query_lineage.QueryLineageInput, options: query_lineage.Options) !query_lineage.QueryLineageOutput {
        return query_lineage.execute(self, allocator, input, options);
    }

    /// Register devices.
    pub fn registerDevices(self: *Self, allocator: std.mem.Allocator, input: register_devices.RegisterDevicesInput, options: register_devices.Options) !register_devices.RegisterDevicesOutput {
        return register_devices.execute(self, allocator, input, options);
    }

    /// Renders the UI template so that you can preview the worker's experience.
    pub fn renderUiTemplate(self: *Self, allocator: std.mem.Allocator, input: render_ui_template.RenderUiTemplateInput, options: render_ui_template.Options) !render_ui_template.RenderUiTemplateOutput {
        return render_ui_template.execute(self, allocator, input, options);
    }

    /// Retry the execution of the pipeline.
    pub fn retryPipelineExecution(self: *Self, allocator: std.mem.Allocator, input: retry_pipeline_execution.RetryPipelineExecutionInput, options: retry_pipeline_execution.Options) !retry_pipeline_execution.RetryPipelineExecutionOutput {
        return retry_pipeline_execution.execute(self, allocator, input, options);
    }

    /// Finds SageMaker resources that match a search query. Matching resources are
    /// returned as a list of `SearchRecord` objects in the response. You can sort
    /// the search results by any resource property in a ascending or descending
    /// order.
    ///
    /// You can query against the following value types: numeric, text, Boolean, and
    /// timestamp.
    ///
    /// The Search API may provide access to otherwise restricted data. See [Amazon
    /// SageMaker API Permissions: Actions, Permissions, and Resources
    /// Reference](https://docs.aws.amazon.com/sagemaker/latest/dg/api-permissions-reference.html) for more information.
    pub fn search(self: *Self, allocator: std.mem.Allocator, input: search_.SearchInput, options: search_.Options) !search_.SearchOutput {
        return search_.execute(self, allocator, input, options);
    }

    /// Searches for available training plan offerings based on specified criteria.
    ///
    /// * Users search for available plan offerings based on their requirements
    ///   (e.g., instance type, count, start time, duration).
    /// * And then, they create a plan that best matches their needs using the ID of
    ///   the plan offering they want to use.
    ///
    /// For more information about how to reserve GPU capacity for your SageMaker
    /// training jobs or SageMaker HyperPod clusters using Amazon SageMaker Training
    /// Plan , see `
    /// [CreateTrainingPlan](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingPlan.html) `.
    pub fn searchTrainingPlanOfferings(self: *Self, allocator: std.mem.Allocator, input: search_training_plan_offerings.SearchTrainingPlanOfferingsInput, options: search_training_plan_offerings.Options) !search_training_plan_offerings.SearchTrainingPlanOfferingsOutput {
        return search_training_plan_offerings.execute(self, allocator, input, options);
    }

    /// Notifies the pipeline that the execution of a callback step failed, along
    /// with a message describing why. When a callback step is run, the pipeline
    /// generates a callback token and includes the token in a message sent to
    /// Amazon Simple Queue Service (Amazon SQS).
    pub fn sendPipelineExecutionStepFailure(self: *Self, allocator: std.mem.Allocator, input: send_pipeline_execution_step_failure.SendPipelineExecutionStepFailureInput, options: send_pipeline_execution_step_failure.Options) !send_pipeline_execution_step_failure.SendPipelineExecutionStepFailureOutput {
        return send_pipeline_execution_step_failure.execute(self, allocator, input, options);
    }

    /// Notifies the pipeline that the execution of a callback step succeeded and
    /// provides a list of the step's output parameters. When a callback step is
    /// run, the pipeline generates a callback token and includes the token in a
    /// message sent to Amazon Simple Queue Service (Amazon SQS).
    pub fn sendPipelineExecutionStepSuccess(self: *Self, allocator: std.mem.Allocator, input: send_pipeline_execution_step_success.SendPipelineExecutionStepSuccessInput, options: send_pipeline_execution_step_success.Options) !send_pipeline_execution_step_success.SendPipelineExecutionStepSuccessOutput {
        return send_pipeline_execution_step_success.execute(self, allocator, input, options);
    }

    /// Starts a stage in an edge deployment plan.
    pub fn startEdgeDeploymentStage(self: *Self, allocator: std.mem.Allocator, input: start_edge_deployment_stage.StartEdgeDeploymentStageInput, options: start_edge_deployment_stage.Options) !start_edge_deployment_stage.StartEdgeDeploymentStageOutput {
        return start_edge_deployment_stage.execute(self, allocator, input, options);
    }

    /// Starts an inference experiment.
    pub fn startInferenceExperiment(self: *Self, allocator: std.mem.Allocator, input: start_inference_experiment.StartInferenceExperimentInput, options: start_inference_experiment.Options) !start_inference_experiment.StartInferenceExperimentOutput {
        return start_inference_experiment.execute(self, allocator, input, options);
    }

    /// Programmatically start an MLflow Tracking Server.
    pub fn startMlflowTrackingServer(self: *Self, allocator: std.mem.Allocator, input: start_mlflow_tracking_server.StartMlflowTrackingServerInput, options: start_mlflow_tracking_server.Options) !start_mlflow_tracking_server.StartMlflowTrackingServerOutput {
        return start_mlflow_tracking_server.execute(self, allocator, input, options);
    }

    /// Starts a previously stopped monitoring schedule.
    ///
    /// By default, when you successfully create a new schedule, the status of a
    /// monitoring schedule is `scheduled`.
    pub fn startMonitoringSchedule(self: *Self, allocator: std.mem.Allocator, input: start_monitoring_schedule.StartMonitoringScheduleInput, options: start_monitoring_schedule.Options) !start_monitoring_schedule.StartMonitoringScheduleOutput {
        return start_monitoring_schedule.execute(self, allocator, input, options);
    }

    /// Launches an ML compute instance with the latest version of the libraries and
    /// attaches your ML storage volume. After configuring the notebook instance,
    /// SageMaker AI sets the notebook instance status to `InService`. A notebook
    /// instance's status must be `InService` before you can connect to your Jupyter
    /// notebook.
    pub fn startNotebookInstance(self: *Self, allocator: std.mem.Allocator, input: start_notebook_instance.StartNotebookInstanceInput, options: start_notebook_instance.Options) !start_notebook_instance.StartNotebookInstanceOutput {
        return start_notebook_instance.execute(self, allocator, input, options);
    }

    /// Starts a pipeline execution.
    pub fn startPipelineExecution(self: *Self, allocator: std.mem.Allocator, input: start_pipeline_execution.StartPipelineExecutionInput, options: start_pipeline_execution.Options) !start_pipeline_execution.StartPipelineExecutionOutput {
        return start_pipeline_execution.execute(self, allocator, input, options);
    }

    /// Initiates a remote connection session between a local integrated development
    /// environments (IDEs) and a remote SageMaker space.
    pub fn startSession(self: *Self, allocator: std.mem.Allocator, input: start_session.StartSessionInput, options: start_session.Options) !start_session.StartSessionOutput {
        return start_session.execute(self, allocator, input, options);
    }

    /// A method for forcing a running job to shut down.
    pub fn stopAutoMlJob(self: *Self, allocator: std.mem.Allocator, input: stop_auto_ml_job.StopAutoMLJobInput, options: stop_auto_ml_job.Options) !stop_auto_ml_job.StopAutoMLJobOutput {
        return stop_auto_ml_job.execute(self, allocator, input, options);
    }

    /// Stops a model compilation job.
    ///
    /// To stop a job, Amazon SageMaker AI sends the algorithm the SIGTERM signal.
    /// This gracefully shuts the job down. If the job hasn't stopped, it sends the
    /// SIGKILL signal.
    ///
    /// When it receives a `StopCompilationJob` request, Amazon SageMaker AI changes
    /// the `CompilationJobStatus` of the job to `Stopping`. After Amazon SageMaker
    /// stops the job, it sets the `CompilationJobStatus` to `Stopped`.
    pub fn stopCompilationJob(self: *Self, allocator: std.mem.Allocator, input: stop_compilation_job.StopCompilationJobInput, options: stop_compilation_job.Options) !stop_compilation_job.StopCompilationJobOutput {
        return stop_compilation_job.execute(self, allocator, input, options);
    }

    /// Stops a stage in an edge deployment plan.
    pub fn stopEdgeDeploymentStage(self: *Self, allocator: std.mem.Allocator, input: stop_edge_deployment_stage.StopEdgeDeploymentStageInput, options: stop_edge_deployment_stage.Options) !stop_edge_deployment_stage.StopEdgeDeploymentStageOutput {
        return stop_edge_deployment_stage.execute(self, allocator, input, options);
    }

    /// Request to stop an edge packaging job.
    pub fn stopEdgePackagingJob(self: *Self, allocator: std.mem.Allocator, input: stop_edge_packaging_job.StopEdgePackagingJobInput, options: stop_edge_packaging_job.Options) !stop_edge_packaging_job.StopEdgePackagingJobOutput {
        return stop_edge_packaging_job.execute(self, allocator, input, options);
    }

    /// Stops a running hyperparameter tuning job and all running training jobs that
    /// the tuning job launched.
    ///
    /// All model artifacts output from the training jobs are stored in Amazon
    /// Simple Storage Service (Amazon S3). All data that the training jobs write to
    /// Amazon CloudWatch Logs are still available in CloudWatch. After the tuning
    /// job moves to the `Stopped` state, it releases all reserved resources for the
    /// tuning job.
    pub fn stopHyperParameterTuningJob(self: *Self, allocator: std.mem.Allocator, input: stop_hyper_parameter_tuning_job.StopHyperParameterTuningJobInput, options: stop_hyper_parameter_tuning_job.Options) !stop_hyper_parameter_tuning_job.StopHyperParameterTuningJobOutput {
        return stop_hyper_parameter_tuning_job.execute(self, allocator, input, options);
    }

    /// Stops an inference experiment.
    pub fn stopInferenceExperiment(self: *Self, allocator: std.mem.Allocator, input: stop_inference_experiment.StopInferenceExperimentInput, options: stop_inference_experiment.Options) !stop_inference_experiment.StopInferenceExperimentOutput {
        return stop_inference_experiment.execute(self, allocator, input, options);
    }

    /// Stops an Inference Recommender job.
    pub fn stopInferenceRecommendationsJob(self: *Self, allocator: std.mem.Allocator, input: stop_inference_recommendations_job.StopInferenceRecommendationsJobInput, options: stop_inference_recommendations_job.Options) !stop_inference_recommendations_job.StopInferenceRecommendationsJobOutput {
        return stop_inference_recommendations_job.execute(self, allocator, input, options);
    }

    /// Stops a running labeling job. A job that is stopped cannot be restarted. Any
    /// results obtained before the job is stopped are placed in the Amazon S3
    /// output bucket.
    pub fn stopLabelingJob(self: *Self, allocator: std.mem.Allocator, input: stop_labeling_job.StopLabelingJobInput, options: stop_labeling_job.Options) !stop_labeling_job.StopLabelingJobOutput {
        return stop_labeling_job.execute(self, allocator, input, options);
    }

    /// Programmatically stop an MLflow Tracking Server.
    pub fn stopMlflowTrackingServer(self: *Self, allocator: std.mem.Allocator, input: stop_mlflow_tracking_server.StopMlflowTrackingServerInput, options: stop_mlflow_tracking_server.Options) !stop_mlflow_tracking_server.StopMlflowTrackingServerOutput {
        return stop_mlflow_tracking_server.execute(self, allocator, input, options);
    }

    /// Stops a previously started monitoring schedule.
    pub fn stopMonitoringSchedule(self: *Self, allocator: std.mem.Allocator, input: stop_monitoring_schedule.StopMonitoringScheduleInput, options: stop_monitoring_schedule.Options) !stop_monitoring_schedule.StopMonitoringScheduleOutput {
        return stop_monitoring_schedule.execute(self, allocator, input, options);
    }

    /// Terminates the ML compute instance. Before terminating the instance,
    /// SageMaker AI disconnects the ML storage volume from it. SageMaker AI
    /// preserves the ML storage volume. SageMaker AI stops charging you for the ML
    /// compute instance when you call `StopNotebookInstance`.
    ///
    /// To access data on the ML storage volume for a notebook instance that has
    /// been terminated, call the `StartNotebookInstance` API.
    /// `StartNotebookInstance` launches another ML compute instance, configures it,
    /// and attaches the preserved ML storage volume so you can continue your work.
    pub fn stopNotebookInstance(self: *Self, allocator: std.mem.Allocator, input: stop_notebook_instance.StopNotebookInstanceInput, options: stop_notebook_instance.Options) !stop_notebook_instance.StopNotebookInstanceOutput {
        return stop_notebook_instance.execute(self, allocator, input, options);
    }

    /// Ends a running inference optimization job.
    pub fn stopOptimizationJob(self: *Self, allocator: std.mem.Allocator, input: stop_optimization_job.StopOptimizationJobInput, options: stop_optimization_job.Options) !stop_optimization_job.StopOptimizationJobOutput {
        return stop_optimization_job.execute(self, allocator, input, options);
    }

    /// Stops a pipeline execution.
    ///
    /// **Callback Step**
    ///
    /// A pipeline execution won't stop while a callback step is running. When you
    /// call `StopPipelineExecution` on a pipeline execution with a running callback
    /// step, SageMaker Pipelines sends an additional Amazon SQS message to the
    /// specified SQS queue. The body of the SQS message contains a "Status" field
    /// which is set to "Stopping".
    ///
    /// You should add logic to your Amazon SQS message consumer to take any needed
    /// action (for example, resource cleanup) upon receipt of the message followed
    /// by a call to `SendPipelineExecutionStepSuccess` or
    /// `SendPipelineExecutionStepFailure`.
    ///
    /// Only when SageMaker Pipelines receives one of these calls will it stop the
    /// pipeline execution.
    ///
    /// **Lambda Step**
    ///
    /// A pipeline execution can't be stopped while a lambda step is running because
    /// the Lambda function invoked by the lambda step can't be stopped. If you
    /// attempt to stop the execution while the Lambda function is running, the
    /// pipeline waits for the Lambda function to finish or until the timeout is
    /// hit, whichever occurs first, and then stops. If the Lambda function
    /// finishes, the pipeline execution status is `Stopped`. If the timeout is hit
    /// the pipeline execution status is `Failed`.
    pub fn stopPipelineExecution(self: *Self, allocator: std.mem.Allocator, input: stop_pipeline_execution.StopPipelineExecutionInput, options: stop_pipeline_execution.Options) !stop_pipeline_execution.StopPipelineExecutionOutput {
        return stop_pipeline_execution.execute(self, allocator, input, options);
    }

    /// Stops a processing job.
    pub fn stopProcessingJob(self: *Self, allocator: std.mem.Allocator, input: stop_processing_job.StopProcessingJobInput, options: stop_processing_job.Options) !stop_processing_job.StopProcessingJobOutput {
        return stop_processing_job.execute(self, allocator, input, options);
    }

    /// Stops a training job. To stop a job, SageMaker sends the algorithm the
    /// `SIGTERM` signal, which delays job termination for 120 seconds. Algorithms
    /// might use this 120-second window to save the model artifacts, so the results
    /// of the training is not lost.
    ///
    /// When it receives a `StopTrainingJob` request, SageMaker changes the status
    /// of the job to `Stopping`. After SageMaker stops the job, it sets the status
    /// to `Stopped`.
    pub fn stopTrainingJob(self: *Self, allocator: std.mem.Allocator, input: stop_training_job.StopTrainingJobInput, options: stop_training_job.Options) !stop_training_job.StopTrainingJobOutput {
        return stop_training_job.execute(self, allocator, input, options);
    }

    /// Stops a batch transform job.
    ///
    /// When Amazon SageMaker receives a `StopTransformJob` request, the status of
    /// the job changes to `Stopping`. After Amazon SageMaker stops the job, the
    /// status is set to `Stopped`. When you stop a batch transform job before it is
    /// completed, Amazon SageMaker doesn't store the job's output in Amazon S3.
    pub fn stopTransformJob(self: *Self, allocator: std.mem.Allocator, input: stop_transform_job.StopTransformJobInput, options: stop_transform_job.Options) !stop_transform_job.StopTransformJobOutput {
        return stop_transform_job.execute(self, allocator, input, options);
    }

    /// Updates an action.
    pub fn updateAction(self: *Self, allocator: std.mem.Allocator, input: update_action.UpdateActionInput, options: update_action.Options) !update_action.UpdateActionOutput {
        return update_action.execute(self, allocator, input, options);
    }

    /// Updates the properties of an AppImageConfig.
    pub fn updateAppImageConfig(self: *Self, allocator: std.mem.Allocator, input: update_app_image_config.UpdateAppImageConfigInput, options: update_app_image_config.Options) !update_app_image_config.UpdateAppImageConfigOutput {
        return update_app_image_config.execute(self, allocator, input, options);
    }

    /// Updates an artifact.
    pub fn updateArtifact(self: *Self, allocator: std.mem.Allocator, input: update_artifact.UpdateArtifactInput, options: update_artifact.Options) !update_artifact.UpdateArtifactOutput {
        return update_artifact.execute(self, allocator, input, options);
    }

    /// Updates a SageMaker HyperPod cluster.
    pub fn updateCluster(self: *Self, allocator: std.mem.Allocator, input: update_cluster.UpdateClusterInput, options: update_cluster.Options) !update_cluster.UpdateClusterOutput {
        return update_cluster.execute(self, allocator, input, options);
    }

    /// Update the cluster policy configuration.
    pub fn updateClusterSchedulerConfig(self: *Self, allocator: std.mem.Allocator, input: update_cluster_scheduler_config.UpdateClusterSchedulerConfigInput, options: update_cluster_scheduler_config.Options) !update_cluster_scheduler_config.UpdateClusterSchedulerConfigOutput {
        return update_cluster_scheduler_config.execute(self, allocator, input, options);
    }

    /// Updates the platform software of a SageMaker HyperPod cluster for security
    /// patching. To learn how to use this API, see [Update the SageMaker HyperPod
    /// platform software of a
    /// cluster](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-hyperpod-operate.html#sagemaker-hyperpod-operate-cli-command-update-cluster-software).
    ///
    /// The `UpgradeClusterSoftware` API call may impact your SageMaker HyperPod
    /// cluster uptime and availability. Plan accordingly to mitigate potential
    /// disruptions to your workloads.
    pub fn updateClusterSoftware(self: *Self, allocator: std.mem.Allocator, input: update_cluster_software.UpdateClusterSoftwareInput, options: update_cluster_software.Options) !update_cluster_software.UpdateClusterSoftwareOutput {
        return update_cluster_software.execute(self, allocator, input, options);
    }

    /// Updates the specified Git repository with the specified values.
    pub fn updateCodeRepository(self: *Self, allocator: std.mem.Allocator, input: update_code_repository.UpdateCodeRepositoryInput, options: update_code_repository.Options) !update_code_repository.UpdateCodeRepositoryOutput {
        return update_code_repository.execute(self, allocator, input, options);
    }

    /// Update the compute allocation definition.
    pub fn updateComputeQuota(self: *Self, allocator: std.mem.Allocator, input: update_compute_quota.UpdateComputeQuotaInput, options: update_compute_quota.Options) !update_compute_quota.UpdateComputeQuotaOutput {
        return update_compute_quota.execute(self, allocator, input, options);
    }

    /// Updates a context.
    pub fn updateContext(self: *Self, allocator: std.mem.Allocator, input: update_context.UpdateContextInput, options: update_context.Options) !update_context.UpdateContextOutput {
        return update_context.execute(self, allocator, input, options);
    }

    /// Updates a fleet of devices.
    pub fn updateDeviceFleet(self: *Self, allocator: std.mem.Allocator, input: update_device_fleet.UpdateDeviceFleetInput, options: update_device_fleet.Options) !update_device_fleet.UpdateDeviceFleetOutput {
        return update_device_fleet.execute(self, allocator, input, options);
    }

    /// Updates one or more devices in a fleet.
    pub fn updateDevices(self: *Self, allocator: std.mem.Allocator, input: update_devices.UpdateDevicesInput, options: update_devices.Options) !update_devices.UpdateDevicesOutput {
        return update_devices.execute(self, allocator, input, options);
    }

    /// Updates the default settings for new user profiles in the domain.
    pub fn updateDomain(self: *Self, allocator: std.mem.Allocator, input: update_domain.UpdateDomainInput, options: update_domain.Options) !update_domain.UpdateDomainOutput {
        return update_domain.execute(self, allocator, input, options);
    }

    /// Deploys the `EndpointConfig` specified in the request to a new fleet of
    /// instances. SageMaker shifts endpoint traffic to the new instances with the
    /// updated endpoint configuration and then deletes the old instances using the
    /// previous `EndpointConfig` (there is no availability loss). For more
    /// information about how to control the update and traffic shifting process,
    /// see [ Update models in
    /// production](https://docs.aws.amazon.com/sagemaker/latest/dg/deployment-guardrails.html).
    ///
    /// When SageMaker receives the request, it sets the endpoint status to
    /// `Updating`. After updating the endpoint, it sets the status to `InService`.
    /// To check the status of an endpoint, use the
    /// [DescribeEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeEndpoint.html) API.
    ///
    /// You must not delete an `EndpointConfig` in use by an endpoint that is live
    /// or while the `UpdateEndpoint` or `CreateEndpoint` operations are being
    /// performed on the endpoint. To update an endpoint, you must create a new
    /// `EndpointConfig`.
    ///
    /// If you delete the `EndpointConfig` of an endpoint that is active or being
    /// created or updated you may lose visibility into the instance type the
    /// endpoint is using. The endpoint must be deleted in order to stop incurring
    /// charges.
    pub fn updateEndpoint(self: *Self, allocator: std.mem.Allocator, input: update_endpoint.UpdateEndpointInput, options: update_endpoint.Options) !update_endpoint.UpdateEndpointOutput {
        return update_endpoint.execute(self, allocator, input, options);
    }

    /// Updates variant weight of one or more variants associated with an existing
    /// endpoint, or capacity of one variant associated with an existing endpoint.
    /// When it receives the request, SageMaker sets the endpoint status to
    /// `Updating`. After updating the endpoint, it sets the status to `InService`.
    /// To check the status of an endpoint, use the
    /// [DescribeEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeEndpoint.html) API.
    pub fn updateEndpointWeightsAndCapacities(self: *Self, allocator: std.mem.Allocator, input: update_endpoint_weights_and_capacities.UpdateEndpointWeightsAndCapacitiesInput, options: update_endpoint_weights_and_capacities.Options) !update_endpoint_weights_and_capacities.UpdateEndpointWeightsAndCapacitiesOutput {
        return update_endpoint_weights_and_capacities.execute(self, allocator, input, options);
    }

    /// Adds, updates, or removes the description of an experiment. Updates the
    /// display name of an experiment.
    pub fn updateExperiment(self: *Self, allocator: std.mem.Allocator, input: update_experiment.UpdateExperimentInput, options: update_experiment.Options) !update_experiment.UpdateExperimentOutput {
        return update_experiment.execute(self, allocator, input, options);
    }

    /// Updates the feature group by either adding features or updating the online
    /// store configuration. Use one of the following request parameters at a time
    /// while using the `UpdateFeatureGroup` API.
    ///
    /// You can add features for your feature group using the `FeatureAdditions`
    /// request parameter. Features cannot be removed from a feature group.
    ///
    /// You can update the online store configuration by using the
    /// `OnlineStoreConfig` request parameter. If a `TtlDuration` is specified, the
    /// default `TtlDuration` applies for all records added to the feature group
    /// *after the feature group is updated*. If a record level `TtlDuration` exists
    /// from using the `PutRecord` API, the record level `TtlDuration` applies to
    /// that record instead of the default `TtlDuration`. To remove the default
    /// `TtlDuration` from an existing feature group, use the `UpdateFeatureGroup`
    /// API and set the `TtlDuration` `Unit` and `Value` to `null`.
    pub fn updateFeatureGroup(self: *Self, allocator: std.mem.Allocator, input: update_feature_group.UpdateFeatureGroupInput, options: update_feature_group.Options) !update_feature_group.UpdateFeatureGroupOutput {
        return update_feature_group.execute(self, allocator, input, options);
    }

    /// Updates the description and parameters of the feature group.
    pub fn updateFeatureMetadata(self: *Self, allocator: std.mem.Allocator, input: update_feature_metadata.UpdateFeatureMetadataInput, options: update_feature_metadata.Options) !update_feature_metadata.UpdateFeatureMetadataOutput {
        return update_feature_metadata.execute(self, allocator, input, options);
    }

    /// Update a hub.
    pub fn updateHub(self: *Self, allocator: std.mem.Allocator, input: update_hub.UpdateHubInput, options: update_hub.Options) !update_hub.UpdateHubOutput {
        return update_hub.execute(self, allocator, input, options);
    }

    /// Updates SageMaker hub content (either a `Model` or `Notebook` resource).
    ///
    /// You can update the metadata that describes the resource. In addition to the
    /// required request fields, specify at least one of the following fields to
    /// update:
    ///
    /// * `HubContentDescription`
    /// * `HubContentDisplayName`
    /// * `HubContentMarkdown`
    /// * `HubContentSearchKeywords`
    /// * `SupportStatus`
    ///
    /// For more information about hubs, see [Private curated hubs for foundation
    /// model access control in
    /// JumpStart](https://docs.aws.amazon.com/sagemaker/latest/dg/jumpstart-curated-hubs.html).
    ///
    /// If you want to update a `ModelReference` resource in your hub, use the
    /// `UpdateHubContentResource` API instead.
    pub fn updateHubContent(self: *Self, allocator: std.mem.Allocator, input: update_hub_content.UpdateHubContentInput, options: update_hub_content.Options) !update_hub_content.UpdateHubContentOutput {
        return update_hub_content.execute(self, allocator, input, options);
    }

    /// Updates the contents of a SageMaker hub for a `ModelReference` resource. A
    /// `ModelReference` allows you to access public SageMaker JumpStart models from
    /// within your private hub.
    ///
    /// When using this API, you can update the `MinVersion` field for additional
    /// flexibility in the model version. You shouldn't update any additional fields
    /// when using this API, because the metadata in your private hub should match
    /// the public JumpStart model's metadata.
    ///
    /// If you want to update a `Model` or `Notebook` resource in your hub, use the
    /// `UpdateHubContent` API instead.
    ///
    /// For more information about adding model references to your hub, see [ Add
    /// models to a private
    /// hub](https://docs.aws.amazon.com/sagemaker/latest/dg/jumpstart-curated-hubs-admin-guide-add-models.html).
    pub fn updateHubContentReference(self: *Self, allocator: std.mem.Allocator, input: update_hub_content_reference.UpdateHubContentReferenceInput, options: update_hub_content_reference.Options) !update_hub_content_reference.UpdateHubContentReferenceOutput {
        return update_hub_content_reference.execute(self, allocator, input, options);
    }

    /// Updates the properties of a SageMaker AI image. To change the image's tags,
    /// use the
    /// [AddTags](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AddTags.html) and [DeleteTags](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DeleteTags.html) APIs.
    pub fn updateImage(self: *Self, allocator: std.mem.Allocator, input: update_image.UpdateImageInput, options: update_image.Options) !update_image.UpdateImageOutput {
        return update_image.execute(self, allocator, input, options);
    }

    /// Updates the properties of a SageMaker AI image version.
    pub fn updateImageVersion(self: *Self, allocator: std.mem.Allocator, input: update_image_version.UpdateImageVersionInput, options: update_image_version.Options) !update_image_version.UpdateImageVersionOutput {
        return update_image_version.execute(self, allocator, input, options);
    }

    /// Updates an inference component.
    pub fn updateInferenceComponent(self: *Self, allocator: std.mem.Allocator, input: update_inference_component.UpdateInferenceComponentInput, options: update_inference_component.Options) !update_inference_component.UpdateInferenceComponentOutput {
        return update_inference_component.execute(self, allocator, input, options);
    }

    /// Runtime settings for a model that is deployed with an inference component.
    pub fn updateInferenceComponentRuntimeConfig(self: *Self, allocator: std.mem.Allocator, input: update_inference_component_runtime_config.UpdateInferenceComponentRuntimeConfigInput, options: update_inference_component_runtime_config.Options) !update_inference_component_runtime_config.UpdateInferenceComponentRuntimeConfigOutput {
        return update_inference_component_runtime_config.execute(self, allocator, input, options);
    }

    /// Updates an inference experiment that you created. The status of the
    /// inference experiment has to be either `Created`, `Running`. For more
    /// information on the status of an inference experiment, see
    /// [DescribeInferenceExperiment](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeInferenceExperiment.html).
    pub fn updateInferenceExperiment(self: *Self, allocator: std.mem.Allocator, input: update_inference_experiment.UpdateInferenceExperimentInput, options: update_inference_experiment.Options) !update_inference_experiment.UpdateInferenceExperimentOutput {
        return update_inference_experiment.execute(self, allocator, input, options);
    }

    /// Updates an MLflow App.
    pub fn updateMlflowApp(self: *Self, allocator: std.mem.Allocator, input: update_mlflow_app.UpdateMlflowAppInput, options: update_mlflow_app.Options) !update_mlflow_app.UpdateMlflowAppOutput {
        return update_mlflow_app.execute(self, allocator, input, options);
    }

    /// Updates properties of an existing MLflow Tracking Server.
    pub fn updateMlflowTrackingServer(self: *Self, allocator: std.mem.Allocator, input: update_mlflow_tracking_server.UpdateMlflowTrackingServerInput, options: update_mlflow_tracking_server.Options) !update_mlflow_tracking_server.UpdateMlflowTrackingServerOutput {
        return update_mlflow_tracking_server.execute(self, allocator, input, options);
    }

    /// Update an Amazon SageMaker Model Card.
    ///
    /// You cannot update both model card content and model card status in a single
    /// call.
    pub fn updateModelCard(self: *Self, allocator: std.mem.Allocator, input: update_model_card.UpdateModelCardInput, options: update_model_card.Options) !update_model_card.UpdateModelCardOutput {
        return update_model_card.execute(self, allocator, input, options);
    }

    /// Updates a versioned model.
    pub fn updateModelPackage(self: *Self, allocator: std.mem.Allocator, input: update_model_package.UpdateModelPackageInput, options: update_model_package.Options) !update_model_package.UpdateModelPackageOutput {
        return update_model_package.execute(self, allocator, input, options);
    }

    /// Update the parameters of a model monitor alert.
    pub fn updateMonitoringAlert(self: *Self, allocator: std.mem.Allocator, input: update_monitoring_alert.UpdateMonitoringAlertInput, options: update_monitoring_alert.Options) !update_monitoring_alert.UpdateMonitoringAlertOutput {
        return update_monitoring_alert.execute(self, allocator, input, options);
    }

    /// Updates a previously created schedule.
    pub fn updateMonitoringSchedule(self: *Self, allocator: std.mem.Allocator, input: update_monitoring_schedule.UpdateMonitoringScheduleInput, options: update_monitoring_schedule.Options) !update_monitoring_schedule.UpdateMonitoringScheduleOutput {
        return update_monitoring_schedule.execute(self, allocator, input, options);
    }

    /// Updates a notebook instance. NotebookInstance updates include upgrading or
    /// downgrading the ML compute instance used for your notebook instance to
    /// accommodate changes in your workload requirements.
    ///
    /// This API can attach lifecycle configurations to notebook instances.
    /// Lifecycle configuration scripts execute with root access and the notebook
    /// instance's IAM execution role privileges. Principals with this permission
    /// and access to lifecycle configurations can execute code with the execution
    /// role's credentials. See [Customize a Notebook Instance Using a Lifecycle
    /// Configuration
    /// Script](https://docs.aws.amazon.com/sagemaker/latest/dg/notebook-lifecycle-config.html) for security best practices.
    pub fn updateNotebookInstance(self: *Self, allocator: std.mem.Allocator, input: update_notebook_instance.UpdateNotebookInstanceInput, options: update_notebook_instance.Options) !update_notebook_instance.UpdateNotebookInstanceOutput {
        return update_notebook_instance.execute(self, allocator, input, options);
    }

    /// Updates a notebook instance lifecycle configuration created with the
    /// [CreateNotebookInstanceLifecycleConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateNotebookInstanceLifecycleConfig.html) API.
    ///
    /// Updates to lifecycle configurations affect all notebook instances using that
    /// configuration upon their next start. Lifecycle configuration scripts execute
    /// with root access and the notebook instance's IAM execution role privileges.
    /// Grant this permission only to trusted principals. See [Customize a Notebook
    /// Instance Using a Lifecycle Configuration
    /// Script](https://docs.aws.amazon.com/sagemaker/latest/dg/notebook-lifecycle-config.html) for security best practices.
    pub fn updateNotebookInstanceLifecycleConfig(self: *Self, allocator: std.mem.Allocator, input: update_notebook_instance_lifecycle_config.UpdateNotebookInstanceLifecycleConfigInput, options: update_notebook_instance_lifecycle_config.Options) !update_notebook_instance_lifecycle_config.UpdateNotebookInstanceLifecycleConfigOutput {
        return update_notebook_instance_lifecycle_config.execute(self, allocator, input, options);
    }

    /// Updates all of the SageMaker Partner AI Apps in an account.
    pub fn updatePartnerApp(self: *Self, allocator: std.mem.Allocator, input: update_partner_app.UpdatePartnerAppInput, options: update_partner_app.Options) !update_partner_app.UpdatePartnerAppOutput {
        return update_partner_app.execute(self, allocator, input, options);
    }

    /// Updates a pipeline.
    pub fn updatePipeline(self: *Self, allocator: std.mem.Allocator, input: update_pipeline.UpdatePipelineInput, options: update_pipeline.Options) !update_pipeline.UpdatePipelineOutput {
        return update_pipeline.execute(self, allocator, input, options);
    }

    /// Updates a pipeline execution.
    pub fn updatePipelineExecution(self: *Self, allocator: std.mem.Allocator, input: update_pipeline_execution.UpdatePipelineExecutionInput, options: update_pipeline_execution.Options) !update_pipeline_execution.UpdatePipelineExecutionOutput {
        return update_pipeline_execution.execute(self, allocator, input, options);
    }

    /// Updates a pipeline version.
    pub fn updatePipelineVersion(self: *Self, allocator: std.mem.Allocator, input: update_pipeline_version.UpdatePipelineVersionInput, options: update_pipeline_version.Options) !update_pipeline_version.UpdatePipelineVersionOutput {
        return update_pipeline_version.execute(self, allocator, input, options);
    }

    /// Updates a machine learning (ML) project that is created from a template that
    /// sets up an ML pipeline from training to deploying an approved model.
    ///
    /// You must not update a project that is in use. If you update the
    /// `ServiceCatalogProvisioningUpdateDetails` of a project that is active or
    /// being created, or updated, you may lose resources already created by the
    /// project.
    pub fn updateProject(self: *Self, allocator: std.mem.Allocator, input: update_project.UpdateProjectInput, options: update_project.Options) !update_project.UpdateProjectOutput {
        return update_project.execute(self, allocator, input, options);
    }

    /// Updates the settings of a space.
    ///
    /// You can't edit the app type of a space in the `SpaceSettings`.
    pub fn updateSpace(self: *Self, allocator: std.mem.Allocator, input: update_space.UpdateSpaceInput, options: update_space.Options) !update_space.UpdateSpaceOutput {
        return update_space.execute(self, allocator, input, options);
    }

    /// Update a model training job to request a new Debugger profiling
    /// configuration or to change warm pool retention length.
    pub fn updateTrainingJob(self: *Self, allocator: std.mem.Allocator, input: update_training_job.UpdateTrainingJobInput, options: update_training_job.Options) !update_training_job.UpdateTrainingJobOutput {
        return update_training_job.execute(self, allocator, input, options);
    }

    /// Updates the display name of a trial.
    pub fn updateTrial(self: *Self, allocator: std.mem.Allocator, input: update_trial.UpdateTrialInput, options: update_trial.Options) !update_trial.UpdateTrialOutput {
        return update_trial.execute(self, allocator, input, options);
    }

    /// Updates one or more properties of a trial component.
    pub fn updateTrialComponent(self: *Self, allocator: std.mem.Allocator, input: update_trial_component.UpdateTrialComponentInput, options: update_trial_component.Options) !update_trial_component.UpdateTrialComponentOutput {
        return update_trial_component.execute(self, allocator, input, options);
    }

    /// Updates a user profile.
    pub fn updateUserProfile(self: *Self, allocator: std.mem.Allocator, input: update_user_profile.UpdateUserProfileInput, options: update_user_profile.Options) !update_user_profile.UpdateUserProfileOutput {
        return update_user_profile.execute(self, allocator, input, options);
    }

    /// Use this operation to update your workforce. You can use this operation to
    /// require that workers use specific IP addresses to work on tasks and to
    /// update your OpenID Connect (OIDC) Identity Provider (IdP) workforce
    /// configuration.
    ///
    /// The worker portal is now supported in VPC and public internet.
    ///
    /// Use `SourceIpConfig` to restrict worker access to tasks to a specific range
    /// of IP addresses. You specify allowed IP addresses by creating a list of up
    /// to ten
    /// [CIDRs](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html).
    /// By default, a workforce isn't restricted to specific IP addresses. If you
    /// specify a range of IP addresses, workers who attempt to access tasks using
    /// any IP address outside the specified range are denied and get a `Not Found`
    /// error message on the worker portal.
    ///
    /// To restrict public internet access for all workers, configure the
    /// `SourceIpConfig` CIDR value. For example, when using `SourceIpConfig` with
    /// an `IpAddressType` of `IPv4`, you can restrict access to the IPv4 CIDR block
    /// "10.0.0.0/16". When using an `IpAddressType` of `dualstack`, you can specify
    /// both the IPv4 and IPv6 CIDR blocks, such as "10.0.0.0/16" for IPv4 only,
    /// "2001:db8:1234:1a00::/56" for IPv6 only, or "10.0.0.0/16" and
    /// "2001:db8:1234:1a00::/56" for dual stack.
    ///
    /// Amazon SageMaker does not support Source Ip restriction for worker portals
    /// in VPC.
    ///
    /// Use `OidcConfig` to update the configuration of a workforce created using
    /// your own OIDC IdP.
    ///
    /// You can only update your OIDC IdP configuration when there are no work teams
    /// associated with your workforce. You can delete work teams using the
    /// [DeleteWorkteam](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DeleteWorkteam.html) operation.
    ///
    /// After restricting access to a range of IP addresses or updating your OIDC
    /// IdP configuration with this operation, you can view details about your
    /// update workforce using the
    /// [DescribeWorkforce](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeWorkforce.html) operation.
    ///
    /// This operation only applies to private workforces.
    pub fn updateWorkforce(self: *Self, allocator: std.mem.Allocator, input: update_workforce.UpdateWorkforceInput, options: update_workforce.Options) !update_workforce.UpdateWorkforceOutput {
        return update_workforce.execute(self, allocator, input, options);
    }

    /// Updates an existing work team with new member definitions or description.
    pub fn updateWorkteam(self: *Self, allocator: std.mem.Allocator, input: update_workteam.UpdateWorkteamInput, options: update_workteam.Options) !update_workteam.UpdateWorkteamOutput {
        return update_workteam.execute(self, allocator, input, options);
    }

    pub fn createHubContentPresignedUrlsPaginator(self: *Self, params: create_hub_content_presigned_urls.CreateHubContentPresignedUrlsInput) paginator.CreateHubContentPresignedUrlsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listActionsPaginator(self: *Self, params: list_actions.ListActionsInput) paginator.ListActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAlgorithmsPaginator(self: *Self, params: list_algorithms.ListAlgorithmsInput) paginator.ListAlgorithmsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAliasesPaginator(self: *Self, params: list_aliases.ListAliasesInput) paginator.ListAliasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAppImageConfigsPaginator(self: *Self, params: list_app_image_configs.ListAppImageConfigsInput) paginator.ListAppImageConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAppsPaginator(self: *Self, params: list_apps.ListAppsInput) paginator.ListAppsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listArtifactsPaginator(self: *Self, params: list_artifacts.ListArtifactsInput) paginator.ListArtifactsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssociationsPaginator(self: *Self, params: list_associations.ListAssociationsInput) paginator.ListAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAutoMlJobsPaginator(self: *Self, params: list_auto_ml_jobs.ListAutoMLJobsInput) paginator.ListAutoMLJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCandidatesForAutoMlJobPaginator(self: *Self, params: list_candidates_for_auto_ml_job.ListCandidatesForAutoMLJobInput) paginator.ListCandidatesForAutoMLJobPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClusterEventsPaginator(self: *Self, params: list_cluster_events.ListClusterEventsInput) paginator.ListClusterEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClusterNodesPaginator(self: *Self, params: list_cluster_nodes.ListClusterNodesInput) paginator.ListClusterNodesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClusterSchedulerConfigsPaginator(self: *Self, params: list_cluster_scheduler_configs.ListClusterSchedulerConfigsInput) paginator.ListClusterSchedulerConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClustersPaginator(self: *Self, params: list_clusters.ListClustersInput) paginator.ListClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCodeRepositoriesPaginator(self: *Self, params: list_code_repositories.ListCodeRepositoriesInput) paginator.ListCodeRepositoriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCompilationJobsPaginator(self: *Self, params: list_compilation_jobs.ListCompilationJobsInput) paginator.ListCompilationJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listComputeQuotasPaginator(self: *Self, params: list_compute_quotas.ListComputeQuotasInput) paginator.ListComputeQuotasPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listContextsPaginator(self: *Self, params: list_contexts.ListContextsInput) paginator.ListContextsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataQualityJobDefinitionsPaginator(self: *Self, params: list_data_quality_job_definitions.ListDataQualityJobDefinitionsInput) paginator.ListDataQualityJobDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDeviceFleetsPaginator(self: *Self, params: list_device_fleets.ListDeviceFleetsInput) paginator.ListDeviceFleetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDevicesPaginator(self: *Self, params: list_devices.ListDevicesInput) paginator.ListDevicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDomainsPaginator(self: *Self, params: list_domains.ListDomainsInput) paginator.ListDomainsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEdgeDeploymentPlansPaginator(self: *Self, params: list_edge_deployment_plans.ListEdgeDeploymentPlansInput) paginator.ListEdgeDeploymentPlansPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEdgePackagingJobsPaginator(self: *Self, params: list_edge_packaging_jobs.ListEdgePackagingJobsInput) paginator.ListEdgePackagingJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEndpointConfigsPaginator(self: *Self, params: list_endpoint_configs.ListEndpointConfigsInput) paginator.ListEndpointConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEndpointsPaginator(self: *Self, params: list_endpoints.ListEndpointsInput) paginator.ListEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExperimentsPaginator(self: *Self, params: list_experiments.ListExperimentsInput) paginator.ListExperimentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFeatureGroupsPaginator(self: *Self, params: list_feature_groups.ListFeatureGroupsInput) paginator.ListFeatureGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFlowDefinitionsPaginator(self: *Self, params: list_flow_definitions.ListFlowDefinitionsInput) paginator.ListFlowDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listHumanTaskUisPaginator(self: *Self, params: list_human_task_uis.ListHumanTaskUisInput) paginator.ListHumanTaskUisPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listHyperParameterTuningJobsPaginator(self: *Self, params: list_hyper_parameter_tuning_jobs.ListHyperParameterTuningJobsInput) paginator.ListHyperParameterTuningJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImageVersionsPaginator(self: *Self, params: list_image_versions.ListImageVersionsInput) paginator.ListImageVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImagesPaginator(self: *Self, params: list_images.ListImagesInput) paginator.ListImagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInferenceComponentsPaginator(self: *Self, params: list_inference_components.ListInferenceComponentsInput) paginator.ListInferenceComponentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInferenceExperimentsPaginator(self: *Self, params: list_inference_experiments.ListInferenceExperimentsInput) paginator.ListInferenceExperimentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInferenceRecommendationsJobStepsPaginator(self: *Self, params: list_inference_recommendations_job_steps.ListInferenceRecommendationsJobStepsInput) paginator.ListInferenceRecommendationsJobStepsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInferenceRecommendationsJobsPaginator(self: *Self, params: list_inference_recommendations_jobs.ListInferenceRecommendationsJobsInput) paginator.ListInferenceRecommendationsJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLabelingJobsPaginator(self: *Self, params: list_labeling_jobs.ListLabelingJobsInput) paginator.ListLabelingJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLabelingJobsForWorkteamPaginator(self: *Self, params: list_labeling_jobs_for_workteam.ListLabelingJobsForWorkteamInput) paginator.ListLabelingJobsForWorkteamPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLineageGroupsPaginator(self: *Self, params: list_lineage_groups.ListLineageGroupsInput) paginator.ListLineageGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMlflowAppsPaginator(self: *Self, params: list_mlflow_apps.ListMlflowAppsInput) paginator.ListMlflowAppsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMlflowTrackingServersPaginator(self: *Self, params: list_mlflow_tracking_servers.ListMlflowTrackingServersInput) paginator.ListMlflowTrackingServersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listModelBiasJobDefinitionsPaginator(self: *Self, params: list_model_bias_job_definitions.ListModelBiasJobDefinitionsInput) paginator.ListModelBiasJobDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listModelCardExportJobsPaginator(self: *Self, params: list_model_card_export_jobs.ListModelCardExportJobsInput) paginator.ListModelCardExportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listModelCardVersionsPaginator(self: *Self, params: list_model_card_versions.ListModelCardVersionsInput) paginator.ListModelCardVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listModelCardsPaginator(self: *Self, params: list_model_cards.ListModelCardsInput) paginator.ListModelCardsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listModelExplainabilityJobDefinitionsPaginator(self: *Self, params: list_model_explainability_job_definitions.ListModelExplainabilityJobDefinitionsInput) paginator.ListModelExplainabilityJobDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listModelMetadataPaginator(self: *Self, params: list_model_metadata.ListModelMetadataInput) paginator.ListModelMetadataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listModelPackageGroupsPaginator(self: *Self, params: list_model_package_groups.ListModelPackageGroupsInput) paginator.ListModelPackageGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listModelPackagesPaginator(self: *Self, params: list_model_packages.ListModelPackagesInput) paginator.ListModelPackagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listModelQualityJobDefinitionsPaginator(self: *Self, params: list_model_quality_job_definitions.ListModelQualityJobDefinitionsInput) paginator.ListModelQualityJobDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listModelsPaginator(self: *Self, params: list_models.ListModelsInput) paginator.ListModelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMonitoringAlertHistoryPaginator(self: *Self, params: list_monitoring_alert_history.ListMonitoringAlertHistoryInput) paginator.ListMonitoringAlertHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMonitoringAlertsPaginator(self: *Self, params: list_monitoring_alerts.ListMonitoringAlertsInput) paginator.ListMonitoringAlertsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMonitoringExecutionsPaginator(self: *Self, params: list_monitoring_executions.ListMonitoringExecutionsInput) paginator.ListMonitoringExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMonitoringSchedulesPaginator(self: *Self, params: list_monitoring_schedules.ListMonitoringSchedulesInput) paginator.ListMonitoringSchedulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNotebookInstanceLifecycleConfigsPaginator(self: *Self, params: list_notebook_instance_lifecycle_configs.ListNotebookInstanceLifecycleConfigsInput) paginator.ListNotebookInstanceLifecycleConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNotebookInstancesPaginator(self: *Self, params: list_notebook_instances.ListNotebookInstancesInput) paginator.ListNotebookInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOptimizationJobsPaginator(self: *Self, params: list_optimization_jobs.ListOptimizationJobsInput) paginator.ListOptimizationJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPartnerAppsPaginator(self: *Self, params: list_partner_apps.ListPartnerAppsInput) paginator.ListPartnerAppsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPipelineExecutionStepsPaginator(self: *Self, params: list_pipeline_execution_steps.ListPipelineExecutionStepsInput) paginator.ListPipelineExecutionStepsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPipelineExecutionsPaginator(self: *Self, params: list_pipeline_executions.ListPipelineExecutionsInput) paginator.ListPipelineExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPipelineParametersForExecutionPaginator(self: *Self, params: list_pipeline_parameters_for_execution.ListPipelineParametersForExecutionInput) paginator.ListPipelineParametersForExecutionPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPipelineVersionsPaginator(self: *Self, params: list_pipeline_versions.ListPipelineVersionsInput) paginator.ListPipelineVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPipelinesPaginator(self: *Self, params: list_pipelines.ListPipelinesInput) paginator.ListPipelinesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProcessingJobsPaginator(self: *Self, params: list_processing_jobs.ListProcessingJobsInput) paginator.ListProcessingJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProjectsPaginator(self: *Self, params: list_projects.ListProjectsInput) paginator.ListProjectsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceCatalogsPaginator(self: *Self, params: list_resource_catalogs.ListResourceCatalogsInput) paginator.ListResourceCatalogsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSpacesPaginator(self: *Self, params: list_spaces.ListSpacesInput) paginator.ListSpacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStageDevicesPaginator(self: *Self, params: list_stage_devices.ListStageDevicesInput) paginator.ListStageDevicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStudioLifecycleConfigsPaginator(self: *Self, params: list_studio_lifecycle_configs.ListStudioLifecycleConfigsInput) paginator.ListStudioLifecycleConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSubscribedWorkteamsPaginator(self: *Self, params: list_subscribed_workteams.ListSubscribedWorkteamsInput) paginator.ListSubscribedWorkteamsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagsPaginator(self: *Self, params: list_tags.ListTagsInput) paginator.ListTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrainingJobsPaginator(self: *Self, params: list_training_jobs.ListTrainingJobsInput) paginator.ListTrainingJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrainingJobsForHyperParameterTuningJobPaginator(self: *Self, params: list_training_jobs_for_hyper_parameter_tuning_job.ListTrainingJobsForHyperParameterTuningJobInput) paginator.ListTrainingJobsForHyperParameterTuningJobPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrainingPlansPaginator(self: *Self, params: list_training_plans.ListTrainingPlansInput) paginator.ListTrainingPlansPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTransformJobsPaginator(self: *Self, params: list_transform_jobs.ListTransformJobsInput) paginator.ListTransformJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrialComponentsPaginator(self: *Self, params: list_trial_components.ListTrialComponentsInput) paginator.ListTrialComponentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrialsPaginator(self: *Self, params: list_trials.ListTrialsInput) paginator.ListTrialsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUltraServersByReservedCapacityPaginator(self: *Self, params: list_ultra_servers_by_reserved_capacity.ListUltraServersByReservedCapacityInput) paginator.ListUltraServersByReservedCapacityPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUserProfilesPaginator(self: *Self, params: list_user_profiles.ListUserProfilesInput) paginator.ListUserProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkforcesPaginator(self: *Self, params: list_workforces.ListWorkforcesInput) paginator.ListWorkforcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkteamsPaginator(self: *Self, params: list_workteams.ListWorkteamsInput) paginator.ListWorkteamsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn queryLineagePaginator(self: *Self, params: query_lineage.QueryLineageInput) paginator.QueryLineagePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchPaginator(self: *Self, params: search_.SearchInput) paginator.SearchPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilEndpointDeleted(self: *Self, params: describe_endpoint.DescribeEndpointInput) aws.waiter.WaiterError!void {
        var w = waiters.EndpointDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilEndpointInService(self: *Self, params: describe_endpoint.DescribeEndpointInput) aws.waiter.WaiterError!void {
        var w = waiters.EndpointInServiceWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilImageCreated(self: *Self, params: describe_image.DescribeImageInput) aws.waiter.WaiterError!void {
        var w = waiters.ImageCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilImageDeleted(self: *Self, params: describe_image.DescribeImageInput) aws.waiter.WaiterError!void {
        var w = waiters.ImageDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilImageUpdated(self: *Self, params: describe_image.DescribeImageInput) aws.waiter.WaiterError!void {
        var w = waiters.ImageUpdatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilImageVersionCreated(self: *Self, params: describe_image_version.DescribeImageVersionInput) aws.waiter.WaiterError!void {
        var w = waiters.ImageVersionCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilImageVersionDeleted(self: *Self, params: describe_image_version.DescribeImageVersionInput) aws.waiter.WaiterError!void {
        var w = waiters.ImageVersionDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilNotebookInstanceDeleted(self: *Self, params: describe_notebook_instance.DescribeNotebookInstanceInput) aws.waiter.WaiterError!void {
        var w = waiters.NotebookInstanceDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilNotebookInstanceInService(self: *Self, params: describe_notebook_instance.DescribeNotebookInstanceInput) aws.waiter.WaiterError!void {
        var w = waiters.NotebookInstanceInServiceWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilNotebookInstanceStopped(self: *Self, params: describe_notebook_instance.DescribeNotebookInstanceInput) aws.waiter.WaiterError!void {
        var w = waiters.NotebookInstanceStoppedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilProcessingJobCompletedOrStopped(self: *Self, params: describe_processing_job.DescribeProcessingJobInput) aws.waiter.WaiterError!void {
        var w = waiters.ProcessingJobCompletedOrStoppedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilTrainingJobCompletedOrStopped(self: *Self, params: describe_training_job.DescribeTrainingJobInput) aws.waiter.WaiterError!void {
        var w = waiters.TrainingJobCompletedOrStoppedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilTransformJobCompletedOrStopped(self: *Self, params: describe_transform_job.DescribeTransformJobInput) aws.waiter.WaiterError!void {
        var w = waiters.TransformJobCompletedOrStoppedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
