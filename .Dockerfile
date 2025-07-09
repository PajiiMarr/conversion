# Use the official .NET 9 SDK to build the app
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

WORKDIR /app

# Copy everything and restore as distinct layers
COPY . ./
RUN dotnet restore

# Build and publish the app to the /out directory
RUN dotnet publish -c Release -o /out

# Use the official ASP.NET runtime image for production
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime

WORKDIR /app

# Copy the published output from the build stage
COPY --from=build /out ./

# Set the entry point
ENTRYPOINT ["dotnet", "FinalProject.dll"]
