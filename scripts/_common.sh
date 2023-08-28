add_nginx_config() {
    # Create .well-known redirection with Flathub verification token
    ynh_add_config --template="flathub_verification.conf" --destination="/etc/nginx/conf.d/$domain.d/flathub_verification.conf"

    ynh_systemd_action --service_name=nginx --action=reload
}

remove_nginx_config() {
    ynh_secure_remove --file=/etc/nginx/conf.d/${domain}.d/flathub_verification.conf
    ynh_systemd_action --service_name=nginx --action=reload
}

restore_nginx_config() {
    ynh_restore_file --origin_path="/etc/nginx/conf.d/$domain.d/flathub_verification.conf"
    ynh_systemd_action --service_name=nginx --action=reload
}

change_url_nginx_config() {
    mv "/etc/nginx/conf.d/$old_domain.d/flathub_verification.conf" \
       "/etc/nginx/conf.d/$new_domain.d/flathub_verification.conf"

    ynh_systemd_action --service_name=nginx --action=reload
}
