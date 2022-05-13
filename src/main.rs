use actix_web::{middleware, web, App, HttpResponse, HttpServer};
use env_logger::Env;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    env_logger::init_from_env(Env::default().default_filter_or("info"));

    HttpServer::new(|| {
        App::new()
            .wrap(middleware::Logger::default())
            .route("/hc", web::get().to(get_health_status))
            .default_service(web::route().to(HttpResponse::NotFound))
    })
    .bind(("0.0.0.0", 8080))?
    .run()
    .await
}

async fn get_health_status() -> HttpResponse {
    HttpResponse::Ok()
        .content_type("application/json")
        .body("Healthy")
}
