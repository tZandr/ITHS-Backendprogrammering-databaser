import express from "express";

interface Todo {
    id: number;
    title: string;
    done: boolean;
}

const app = express();
app.use(express.json());