# Architecture Overview

## Vision

A lightweight meal-planning app for one household. Users plan meals for the week, generate grocery lists, and track what is already in the pantry.

## Platforms

- Web app first
- Mobile-friendly browser experience in MVP

## Monorepo Shape

- `apps/web` → primary web app
- `packages/core` → meal planning rules, grocery aggregation, pantry logic
- `packages/ui` → shared visual components
- `packages/db` → persistence access layer

## Deployment

- Web deployed independently
- Backend/API optional in MVP; can start as web-only server actions if the product allows it
